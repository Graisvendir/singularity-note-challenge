import 'dart:async';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/resources/settings_provider.dart';

import 'notes_provider.dart';

class Repository {
  final notesProvider = NotesProvider();
  final settingsProvider = SettingsProvider();

  Future<List<NoteModel>> fetchAllNotes() => notesProvider.fetchAllNotes();
  Future<Settings> fetchSettings() => settingsProvider.fetchSettings();
}