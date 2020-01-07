import 'dart:async';
import 'notes_provider.dart';
import '../models/note_model.dart';

class Repository {
  final notesProvider = NotesProvider();

  Future<List<NoteModel>> fetchAllNotes() => notesProvider.fetchAllNotes();
}