import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';

class ChatException implements Exception {
  ChatException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Talks to the Python FastAPI backend (POST /api/chat).
class ChatService {
  ChatService({required this.sessionId});
  final String sessionId;

  Future<String> ask(String message) async {
    final uri = Uri.parse('$kApiBaseUrl/api/chat');
    try {
      final response = await http
          .post(
            uri,
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode({
              'message': message,
              'session_id': sessionId,
            }),
          )
          // Free hosting can take ~50s to wake up after being idle.
          .timeout(const Duration(seconds: 120));

      dynamic data;
      try {
        data = jsonDecode(utf8.decode(response.bodyBytes));
      } catch (_) {
        data = null;
      }

      if (response.statusCode != 200) {
        final detail = (data is Map) ? data['detail'] : null;
        throw ChatException(
          detail is String
              ? detail
              : 'The assistant could not respond. Please try again.',
        );
      }

      final reply = (data is Map) ? data['reply'] : null;
      if (reply is! String || reply.trim().isEmpty) {
        throw ChatException(
          'The assistant returned an empty answer. Please try again.',
        );
      }
      return reply;
    } on TimeoutException {
      throw ChatException(
        'The assistant is taking too long to respond. It may be waking up, please try again in a moment.',
      );
    } on ChatException {
      rethrow;
    } catch (_) {
      throw ChatException(
        'Could not reach the assistant right now. Please try again later.',
      );
    }
  }
}
