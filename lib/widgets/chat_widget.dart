import 'dart:math' as math;
import 'dart:math' show Random;

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import '../services/chat_service.dart';
import '../theme/app_theme.dart';
import 'common.dart';

enum _Role { user, bot, loading, error }

class _Msg {
  const _Msg(this.role, this.text);
  final _Role role;
  final String text;
}

const List<String> _suggestions = [
  'What projects has Ikram built?',
  'What are his technical skills?',
];

/// Floating "Ikram AI" launcher + chat window.
/// Place it inside a Stack (e.g. `Positioned.fill(child: ChatOverlay())`).
class ChatOverlay extends StatefulWidget {
  const ChatOverlay({super.key});

  @override
  State<ChatOverlay> createState() => _ChatOverlayState();
}

class _ChatOverlayState extends State<ChatOverlay> {
  late final ChatService _service;
  late final String _sessionId;
  final _input = TextEditingController();
  final _focus = FocusNode();
  final _scroll = ScrollController();

  final List<_Msg> _messages = [
    const _Msg(
      _Role.bot,
      "Hi! I'm Ikram AI. Ask me about his skills, projects, education or interests.",
    ),
  ];
  bool _open = false;
  bool _busy = false;
  bool _showSuggestions = true;

  @override
  void initState() {
    super.initState();
    _sessionId =
        '${DateTime.now().microsecondsSinceEpoch}-${Random().nextInt(1 << 31)}';
    _service = ChatService(sessionId: _sessionId);
  }

  @override
  void dispose() {
    _input.dispose();
    _focus.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _open = !_open);
    if (_open) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focus.requestFocus();
      });
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _send(String raw) async {
    final question = raw.trim();
    if (question.isEmpty || _busy) return;

    setState(() {
      _messages.add(_Msg(_Role.user, question));
      _messages.add(const _Msg(_Role.loading, 'Thinking...'));
      _busy = true;
      _showSuggestions = false;
    });
    _input.clear();
    _scrollDown();

    _Msg answer;
    try {
      answer = _Msg(_Role.bot, await _service.ask(question));
    } on ChatException catch (e) {
      answer = _Msg(_Role.error, e.message);
    } catch (_) {
      answer = const _Msg(
        _Role.error,
        'Something went wrong. Please try again.',
      );
    }

    if (!mounted) return;
    setState(() {
      _messages.removeLast(); // the "Thinking..." bubble
      _messages.add(answer);
      _busy = false;
    });
    _scrollDown();
    _focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final small = R.isSmall(context);
    final right = small ? 15.0 : 25.0;

    return Stack(
      children: [
        if (_open)
          Positioned(
            right: right,
            bottom: small ? 75 : 85,
            width: math.min(370, size.width - 30),
            height: math.max(
              240,
              math.min(490, size.height - (small ? 100 : 120)),
            ),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              builder: (context, v, child) => Opacity(
                opacity: v,
                child: Transform.translate(
                  offset: Offset(0, 10 * (1 - v)),
                  child: child,
                ),
              ),
              child: _buildWindow(),
            ),
          ),
        Positioned(
          right: right,
          bottom: small ? 15 : 24,
          child: _Launcher(onTap: _toggle),
        ),
      ],
    );
  }

  Widget _buildWindow() {
    final itemCount = _messages.length + (_showSuggestions ? 1 : 0);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        type: MaterialType.transparency,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFF0B1B2C),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.cyan.o(.22)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x99000000),
                blurRadius: 60,
                offset: Offset(0, 25),
              ),
            ],
          ),
          child: Column(
            children: [
              _header(),
              Expanded(
                child: ListView.separated(
                  controller: _scroll,
                  padding: const EdgeInsets.all(15),
                  itemCount: itemCount,
                  separatorBuilder: (_, _) => const SizedBox(height: 11),
                  itemBuilder: (context, i) {
                    if (i < _messages.length) return _Bubble(_messages[i]);
                    return _suggestionList();
                  },
                ),
              ),
              _form(),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 9),
                child: Text(
                  'AI-generated answers based on the portfolio information.',
                  textAlign: TextAlign.center,
                  style: AppText.body(size: 9, color: const Color(0xFF72899D)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Color(0xFF10243A),
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: AppColors.cyan.o(.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.auto_awesome,
              size: 18,
              color: AppColors.cyan,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ikram AI',
                  style: AppText.body(size: 12, weight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const StatusDot(size: 6),
                    const SizedBox(width: 5),
                    Text(
                      'Portfolio assistant',
                      style: AppText.body(size: 10, color: AppColors.muted),
                    ),
                  ],
                ),
              ],
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _toggle,
              child: const Icon(
                Icons.close,
                size: 22,
                color: Color(0xFF9EB3C6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _suggestionList() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final q in _suggestions)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _send(q),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.cyan.o(.22)),
                    ),
                    child: Text(
                      q,
                      style: AppText.body(size: 10, color: AppColors.cyan),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _form() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _input,
              focusNode: _focus,
              inputFormatters: [LengthLimitingTextInputFormatter(500)],
              textInputAction: TextInputAction.send,
              onSubmitted: _send,
              style: AppText.body(size: 12),
              cursorColor: AppColors.cyan,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: const Color(0xFF071522),
                hintText: 'Ask me something...',
                hintStyle: AppText.body(size: 12, color: AppColors.muted),
                contentPadding: const EdgeInsets.all(11),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.line),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.cyan.o(.5)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _send(_input.text),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.cyan,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_upward,
                  size: 19,
                  color: Color(0xFF04111C),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Launcher extends StatelessWidget {
  const _Launcher({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 11),
          decoration: BoxDecoration(
            color: const Color(0xFF10283D),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.cyan.o(.35)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x77000000),
                blurRadius: 35,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.auto_awesome, size: 18, color: AppColors.cyan),
              const SizedBox(width: 9),
              Text(
                'Ikram AI',
                style: AppText.body(
                  size: 12,
                  weight: FontWeight.w700,
                  color: const Color(0xFFEAFAFF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble(this.msg);

  final _Msg msg;

  @override
  Widget build(BuildContext context) {
    final isUser = msg.role == _Role.user;

    Color bg;
    Color fg;
    Border? border;
    FontStyle? fontStyle;
    double fontSize = 12;

    switch (msg.role) {
      case _Role.user:
        bg = const Color(0xFF07546A);
        fg = const Color(0xFFEFFCFF);
        break;
      case _Role.loading:
        bg = const Color(0xFF142B41);
        fg = const Color(0xFF91A8BC);
        border = Border.all(color: AppColors.line);
        fontStyle = FontStyle.italic;
        fontSize = 11;
        break;
      case _Role.error:
        bg = const Color(0xFF142B41);
        fg = const Color(0xFFFFB4B4);
        border = Border.all(color: AppColors.line);
        break;
      case _Role.bot:
        bg = const Color(0xFF142B41);
        fg = const Color(0xFFDCEBF7);
        border = Border.all(color: AppColors.line);
        break;
    }

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(11),
            border: border,
          ),
          child: SelectableText(
            msg.text,
            style: AppText.body(
              size: fontSize,
              color: fg,
              height: 1.55,
              fontStyle: fontStyle,
            ),
          ),
        ),
      ),
    );
  }
}