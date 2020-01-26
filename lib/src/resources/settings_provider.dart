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
    return box.close();
  }

  Future<void> put(Settings key, setting) async {
    await initBox();
    return box.put(key.toString(), setting);
  }

  Future<dynamic> getSetting(Settings key) async {
    await initBox();
    return box.get(key.toString()) ?? defaultSettings[key];
  }
}