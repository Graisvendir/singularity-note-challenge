import 'dart:async';
import 'package:hive/hive.dart';
import 'package:note_project/src/models/settings.dart';

class SettingsProvider {
  Box box;

  Future<void> initBox() async {
    if (box == null) {
      box = await Hive.openBox('settings');
    }
  }

  Future<void> closeBox() {
    return Hive.close();
  }

  Future<void> putSetting(String key, setting) {
    return box.put(key, setting);
  }

  Future<void> getSetting(String key,) {
    return box.get(key);
  }

  Future<void> put(Settings settings) {
    putSetting('email', settings.email);
    putSetting('evernote', settings.evernote);
    putSetting('singLogin', settings.singLogin);
    putSetting('singPass', settings.singPass);
    putSetting('alwaysSyncEmail', settings.alwaysSyncEmail);
    putSetting('alwaysSyncEvernote', settings.alwaysSyncEvernote);
    putSetting('alwaysSyncSingularity', settings.alwaysSyncSingularity);
    putSetting('theme', settings.theme);
    return null;
  }

  // получение всех заметок из базы
  Future<Settings> fetchSettings() async {
    await initBox();
    final defaultValue = Settings.empty();

    String email = box.get('email');
    String evernote = box.get('evernote');
    String singLogin = box.get('singLogin');
    String singPass = box.get('singPass');
    bool alwaysSyncEmail = box.get('alwaysSyncEmail');
    bool alwaysSyncEvernote = box.get('alwaysSyncEvernote');
    bool alwaysSyncSingularity = box.get('alwaysSyncSingularity');
    bool theme = box.get('theme') ?? defaultValue.theme;
    return Settings(
      email, 
      evernote, 
      singLogin,
      singPass,
      alwaysSyncEmail, 
      alwaysSyncEvernote, 
      alwaysSyncSingularity, 
      theme);
  }
}