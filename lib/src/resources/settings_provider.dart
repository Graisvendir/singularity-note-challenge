import 'dart:async';
import 'package:hive/hive.dart';
import 'package:note_project/src/models/settings.dart';

class NotesProvider {
  Box box;

  Future<void> initBox() async {
    if (box == null) {
      box = await Hive.openBox('settings');
    }
  }

  Future<void> closeBox() {
    return Hive.close();
  }

  Future<void> put(String key, String setting) {
    return box.put(key, setting);
  }

  // получение всех заметок из базы
  Future<Settings> fetchSettings() async {
    await initBox();
    String email = box.get('email');
    String evernote = box.get('evernote');
    bool alwaysSyncEmail = box.get('alwaysSyncEmail');
    bool alwaysSyncEvernote = box.get('alwaysSyncEvernote');
    bool theme = box.get('theme');
    return Settings(email, evernote, alwaysSyncEmail, alwaysSyncEvernote, theme);
  }
}