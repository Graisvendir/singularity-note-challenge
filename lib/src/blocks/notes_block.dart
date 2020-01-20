import 'package:note_project/src/models/note_model.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc {
  MainBloc(this._repository);

  final Repository _repository;
  final _allNotes = BehaviorSubject<List<NoteModel>>();

  Observable<List<NoteModel>> get allNotes => _allNotes.stream;

  Future<void> fetchAllNotes() async {
    final notes = await _repository.fetchAllNotes();
    _allNotes.sink.add(notes);
  }

  Future<void> put(NoteModel note) async {
    await _repository.notesProvider.put(note);
    _allNotes.add([..._allNotes.value, note]);
  }

  Future<void> dispose() async {
    await _allNotes.close();
  }
}