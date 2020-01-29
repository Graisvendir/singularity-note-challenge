import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/resources/settings_provider.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  SettingsBloc(this._repository) :
    settings = Map.unmodifiable({
      for (final key in Settings.values)
        key: BehaviorSubject()
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

  List<String> getRecievers() {
    List<String> recievers = [];
    final email = settings[Settings.email].value;
    final evernote = settings[Settings.evernote].value;
    if (settings[Settings.alwaysSyncEmail].value && email != null && email != '') {
      recievers.add(email);
    }
    if (settings[Settings.alwaysSyncEvernote].value && evernote != null && evernote != '') {
      recievers.add(evernote);
    }

    return recievers;
  }

  Reciever getRecieversBool() {
    final email = settings[Settings.email].value;
    final evernote = settings[Settings.evernote].value;
    final singularity = settings[Settings.singLogin].value;

    final recievers = Reciever()
      ..email = settings[Settings.alwaysSyncEmail].value && email != null && email != ''
      ..evernote = settings[Settings.alwaysSyncEvernote].value && evernote != null && evernote != ''
      ..singularityApp = settings[Settings.alwaysSyncSIngularity].value && singularity != null && singularity != '';

    return recievers;
  }

  Future<void> dispose() async {
    for (final key in settings.keys) {
      await settings[key].close();
    }
  }
}