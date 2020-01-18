import 'dart:async';
import 'package:hive/hive.dart';
import 'package:note_project/src/constants.dart';
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
    putSetting(EMAIL, settings.email);
    putSetting(EVERNOTE, settings.evernote);
    putSetting(SING_LOGIN, settings.singLogin);
    putSetting(SING_PASS, settings.singPass);
    putSetting(ALWAYS_SYNC_EMAIL, settings.alwaysSyncEmail);
    putSetting(ALWAYS_SYNC_EVERNOTE, settings.alwaysSyncEvernote);
    putSetting(ALWAYS_SYNC_SINGULARITY, settings.alwaysSyncSingularity);
    putSetting(THEME, settings.theme);
    return null;
  }

  // получение всех заметок из базы
  Future<Settings> fetchSettings() async {
    await initBox();
    final defaultValue = Settings.empty();

    String email = box.get(EMAIL);
    String evernote = box.get(EVERNOTE);
    String singLogin = box.get(SING_LOGIN);
    String singPass = box.get(SING_PASS);
    bool alwaysSyncEmail = box.get(ALWAYS_SYNC_EMAIL);
    bool alwaysSyncEvernote = box.get(ALWAYS_SYNC_EVERNOTE);
    bool alwaysSyncSingularity = box.get(ALWAYS_SYNC_SINGULARITY);
    bool theme = box.get(THEME) ?? defaultValue.theme;
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