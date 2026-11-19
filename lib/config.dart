import 'package:flutter/foundation.dart';

/// Optional production override:
/// flutter build web --release --dart-define=API_BASE_URL=https://api.example.com
const String _kConfiguredApiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: '',
);

String get kApiBaseUrl {
  if (_kConfiguredApiBaseUrl.isNotEmpty) {
    return _kConfiguredApiBaseUrl;
  }

  if (!kIsWeb) {
    return 'http://127.0.0.1:8000';
  }

  final uri = Uri.base;
  final host = uri.host.toLowerCase();

  if (host == 'localhost' || host == '127.0.0.1') {
    return 'http://127.0.0.1:8000';
  }

  // Codespaces commonly uses:
  // https://CODESPACE_NAME-8080.app.github.dev
  final forwardedSuffix = RegExp(
    r'^(.+)-(\d+)\.(.+)$',
  ).firstMatch(host);
  if (forwardedSuffix != null) {
    final baseName = forwardedSuffix.group(1)!;
    final forwardingDomain = forwardedSuffix.group(3)!;
    return '${uri.scheme}://$baseName-8000.$forwardingDomain';
  }

  // Alternate Codespaces naming format:
  // https://8080-CODESPACE_NAME.app.github.dev
  final portPrefix = RegExp(r'^(\d+)-').firstMatch(host);
  if (portPrefix != null) {
    final backendHost = '8000-${host.substring(portPrefix.end)}';
    return '${uri.scheme}://$backendHost';
  }

  return 'http://127.0.0.1:8000';
}
