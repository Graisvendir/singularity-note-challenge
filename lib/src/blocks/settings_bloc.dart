import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/models/settings.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  SettingsBloc(this._repository);

  final Repository _repository;
  final _settings = BehaviorSubject<Settings>();

  Observable<Settings> get settings => _settings.stream;

  Future<void> fetchSettings() async {
    final settings = await _repository.fetchSettings();
    _settings.sink.add(settings);
  }

  Future<void> put(Settings setting) async {
    await _repository.settingsProvider.put(setting);
    _repository.currentSettings = setting;
    _settings.add(setting);
  }

  Future<void> dispose() async {
    await _settings.close();
  }
}