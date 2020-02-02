import 'dart:convert';

enum Settings {
  email,
  evernote,
  singLogin,
  singPass,
  alwaysSyncEmail,
  alwaysSyncEvernote,
  alwaysSyncSIngularity,
  theme
}

final defaultSettings = Map<Settings, dynamic>.unmodifiable({
  Settings.theme: true,
  Settings.alwaysSyncEmail: true,
  Settings.alwaysSyncEvernote: true,
  Settings.alwaysSyncSIngularity: true,
});

class Auth {
  final String login;
  final String token;

  Auth(this.login, this.token);

  String get authHeader => base64Encode(Utf8Encoder().convert('$login:$token'));
}