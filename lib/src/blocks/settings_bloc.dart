import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/resources/settings_provider.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  SettingsBloc(this._repository) :
    _settings = Map.unmodifiable({
      for (final key in Settings.values)
        key: BehaviorSubject(seedValue: defaultSettings[key])
    }) {
      _settingsStreams = Map.unmodifiable(_settings.map((k,v) => MapEntry(k, v.stream)));
    }

  final Repository _repository;
  
  final Map<Settings, BehaviorSubject<dynamic>> _settings;
  
  Map<Settings, Observable<dynamic>> _settingsStreams;
  Map<Settings, Observable<dynamic>> get settings => _settingsStreams;

  Future<void> fetchSettings() async {
    for (final key in Settings.values) {
      final value = await _repository.settingsProvider.getSetting(key);
      _settings[key].add(value);
    }
  }

  Future<void> put(Settings setting, dynamic value) async {
    await _repository.settingsProvider.put(setting, value);
    _settings[setting].add(value);
  }

  Future<void> dispose() async {
    for (final key in _settings.keys) {
      await _settings[key].close();
    }
  }
}