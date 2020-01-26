import 'dart:async';
import 'package:hive/hive.dart';
import '../models/note_model.dart';

class NotesProvider {
  Box<NoteModel> box;

  Future<void> initBox() async {
    if (box == null) {
      box = await Hive.openBox<NoteModel>('notes');
    }
  }

  Future<void> closeBox() {
    return box.close();
  }

  Future<void> put(NoteModel note) {
    return box.put(note.key, note);
  }

  // получение всех заметок из базы
  Future<List<NoteModel>> fetchAllNotes() async {
    await initBox();
    return box.keys.map((key) => box.get(key)).toList();
  }
}