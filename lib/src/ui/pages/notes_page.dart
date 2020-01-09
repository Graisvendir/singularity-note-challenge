import 'package:flutter/material.dart';
import 'package:note_project/src/blocks/notes_block.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
                children: snapshot.data.map((n) => Text(n.key)).toList(),
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
          ..text = 'text';
        bloc.put(note);
      },
      child: Text('add'),
    );
  }
}