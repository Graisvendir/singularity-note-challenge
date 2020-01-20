import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/resources/settings_provider.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  SettingsBloc(this._repository) :
    settings = Map.unmodifiable({
      for (final key in Settings.values)
        key: BehaviorSubject(seedValue: defaultSettings[key])
    });

  final Repository _repository;
  
  final Map<Settings, BehaviorSubject<dynamic>> settings;

  Future<void> fetchSettings() async {
    for (final key in Settings.values) {
      final value = await _repository.settingsProvider.getSetting(key);
      settings[key].add(value);
    }
  }

  Future<void> put(Settings setting, dynamic value) async {
    await _repository.settingsProvider.put(setting, value);
    settings[setting].add(value);
  }

  Future<void> dispose() async {
    for (final key in settings.keys) {
      await settings[key].close();
    }
  }
}