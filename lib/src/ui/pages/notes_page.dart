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
      ],
    );
  }
}