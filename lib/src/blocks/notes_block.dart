import 'package:note_project/src/models/note_model.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc {
  MainBloc(this._repository);

  final Repository _repository;
  final _allNotes = BehaviorSubject<List<NoteModel>>();

  Observable<List<NoteModel>> get allNotesSorted => 
    _allNotes.stream.map((d) => [...d]..sort((a,b) => -a.dateCreated.compareTo(b.dateCreated)));

  Future<void> fetchAllNotes() async {
    final notes = await _repository.fetchAllNotes();
    _allNotes.sink.add(notes);
  }

  Future<void> put(NoteModel note) async {
    await _repository.notesProvider.put(note);
    int findInList = _allNotes.value.indexWhere((n) => note.key == n.key);
    final newValue = [..._allNotes.value];

    if (findInList == -1) {
      newValue.add(note);
    } else {
      newValue.replaceRange(findInList, findInList + 1, [note]);
    }
    
    _allNotes.add(List<NoteModel>.unmodifiable(newValue));
  }

  Future<void> dispose() async {
    await _allNotes.close();
  }
}