import 'package:flutter/material.dart';
import 'package:note_project/src/blocks/notes_block.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:note_project/src/ui/pages/notes-page/one_note.dart';

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<MainBloc>(context);

    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<List<NoteModel>>(
            stream: bloc.allNotes,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView(
                children: snapshot.data.map((n) => OneNote(data: n)).toList(),
              );
            },
          ),
        ),
        AddButton(),
      ],
    );
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        final bloc = Provider.of<MainBloc>(context, listen: false);
        NoteModel note = NoteModel()
          ..key = Uuid().v4()
          ..imgPath = 'imgPath'
          ..recieverList = [Reciever()..email = true..evernote = false..singularityApp = false]
          ..text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
          ..dateCreated = new DateTime(2020, DateTime.january, 12);
        bloc.put(note);
      },
      child: Text('add'),
    );
  }
}