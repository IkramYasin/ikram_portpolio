import os
import re
import time
from collections import defaultdict, deque
from pathlib import Path

from dotenv import load_dotenv
from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
from google import genai
import uvicorn

from knowledge_base import PORTFOLIO_CONTEXT, SYSTEM_INSTRUCTION

load_dotenv(dotenv_path=Path(__file__).with_name(".env"))

api_key = os.getenv("GEMINI_API_KEY")
if not api_key:
    raise RuntimeError("GEMINI_API_KEY is missing. Add it to backend/.env or your host's environment variables.")

client = genai.Client(
    api_key=api_key,
    http_options={"timeout": 30_000},
)
app = FastAPI(title="Ikram Portfolio API", version="1.1.0")

# Production website origins come from the ALLOWED_ORIGINS environment variable.
# Any localhost port is also allowed so `flutter run -d chrome` works during development.
allowed_origins = [
    origin.strip()
    for origin in os.getenv("ALLOWED_ORIGINS", "").split(",")
    if origin.strip()
]
allowed_origins.extend([
    "https://ikram-portpolio.web.app",
    "https://ikram-portpolio.firebaseapp.com",
])

app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_origin_regex=r"(http://(localhost|127\.0\.0\.1)(:\d+)?|https://[a-z0-9-]+\.(app\.github\.dev|github\.dev|githubpreview\.dev))",
    allow_credentials=False,
    allow_methods=["GET", "POST"],
    allow_headers=["Content-Type"],
)

# Very small in-memory rate limiter (per visitor IP) to protect your Gemini quota.
RATE_LIMIT = 10          # requests
RATE_WINDOW = 60         # per this many seconds
_hits = defaultdict(deque)
_conversation_turns = defaultdict(int)


def _client_ip(request: Request) -> str:
    forwarded = request.headers.get("x-forwarded-for", "")
    if forwarded:
        return forwarded.split(",")[0].strip()
    return request.client.host if request.client else "unknown"


def _check_rate_limit(ip: str) -> None:
    now = time.time()
    hits = _hits[ip]
    while hits and now - hits[0] > RATE_WINDOW:
        hits.popleft()
    if len(hits) >= RATE_LIMIT:
        raise HTTPException(status_code=429, detail="Too many questions. Please wait a minute and try again.")
    hits.append(now)


class ChatRequest(BaseModel):
    message: str = Field(min_length=1, max_length=500)
    session_id: str = Field(default="anonymous", min_length=1, max_length=100)


def _is_email_or_contact_question(question: str) -> bool:
    normalized = question.lower()
    contact_terms = (
        "email",
        "gmail",
        "mail address",
        "email address",
        "contact",
        "reach ikram",
        "send ikram",
    )
    return any(term in normalized for term in contact_terms)


def _contact_answer(is_first_turn: bool) -> str:
    if is_first_turn:
        return (
            "You can contact Ikram from the Contact tab. "
            'Use the "Send an email" button to open your email application '
            "with a prepared message addressed to him. "
            'You can also use the "Connect on LinkedIn" button.'
        )
    return (
        'Open the Contact tab and use the "Send an email" button '
        "to open your email application and send Ikram a message."
    )


def _deduplicate_profile_links(answer: str) -> str:
    seen = set()
    output = []
    profile_link_pattern = (
        r"https://(?:github\.com/IkramYasinUot|"
        r"linkedin\.com/in/ikram-yasin-7b5965363)"
    )

    for line in answer.splitlines():
        urls = re.findall(profile_link_pattern, line)

        if urls and all(url in seen for url in urls):
            continue

        def keep_first(match: re.Match[str]) -> str:
            url = match.group(0)
            if url in seen:
                return ""
            seen.add(url)
            return url

        output.append(re.sub(profile_link_pattern, keep_first, line))

    return "\n".join(output)


def _strip_leading_greeting(answer: str) -> str:
    stripped = answer.strip()
    if not stripped:
        return stripped

    paragraph = stripped.split("\n\n", 1)
    first = paragraph[0].strip()
    if first.lower().startswith(("hello", "hi")):
        if len(paragraph) == 2:
            return paragraph[1].strip()

        greeting_match = re.match(
            r"^(?:(?:Hello|Hi)!?\s*)"
            r"(?:I(?:'m| am)\s+[^.!?]*[.!?]\s*)?",
            stripped,
            flags=re.I,
        )
        if greeting_match:
            remaining = stripped[greeting_match.end():].strip()
            if remaining:
                return remaining
    return stripped


@app.get("/api/health")
def health():
    return {"status": "ok", "service": "Ikram Portfolio API"}


@app.post("/api/chat")
def chat(request: ChatRequest, http_request: Request):
    _check_rate_limit(_client_ip(http_request))

    question = request.message.strip()
    if not question:
        raise HTTPException(status_code=400, detail="Please enter a question.")

    session_turn = _conversation_turns[request.session_id]
    is_first_turn = session_turn == 0
    _conversation_turns[request.session_id] += 1

    if _is_email_or_contact_question(question):
        return {"reply": _contact_answer(is_first_turn)}

    prompt = (
        f"PORTFOLIO INFORMATION:\n{PORTFOLIO_CONTEXT}\n\n"
        f"CONVERSATION POSITION:\n"
        f"{'This is the first question. A greeting is allowed.' if is_first_turn else 'This is a follow-up question. Do not greet and answer directly.'}\n\n"
        f"VISITOR QUESTION:\n{question}"
    )

    try:
        last_error = None
        for model in (
            "gemini-3.1-flash-lite",
            "gemini-3.5-flash",
            "gemini-3.6-flash",
            "gemini-3.7-flash",
        ):
            try:
                response = client.models.generate_content(
                    model=model,
                    contents=prompt,
                    config={
                        "system_instruction": SYSTEM_INSTRUCTION,
                    },
                )
                answer = response.text
                if answer:
                    clean_answer = _deduplicate_profile_links(answer)
                    if not is_first_turn:
                        clean_answer = _strip_leading_greeting(clean_answer)
                    return {"reply": clean_answer}
            except Exception as error:
                last_error = error
                print(f"Gemini model {model} failed: {error}")

        raise RuntimeError(
            "Gemini returned no answer"
            if last_error is None
            else str(last_error)
        )
    except Exception as error:
        print(f"Gemini request failed: {error}")
        raise HTTPException(
            status_code=502,
            detail="The AI service is temporarily unavailable. Please try again.",
        )


if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)
