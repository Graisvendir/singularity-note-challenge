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