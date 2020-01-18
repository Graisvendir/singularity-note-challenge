import 'package:flutter/material.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/ui/pages/notes-page/synchronize_button.dart';
import 'package:note_project/src/ui/pages/notes-page/synchronize_info.dart';

class OneNote extends StatefulWidget {

  final NoteModel data;
  OneNote({NoteModel data}): this.data = data;

  OneNoteState createState() => OneNoteState(data);
}

class OneNoteState extends State<OneNote> {
  
  final NoteModel data;
  OneNoteState(this.data);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              data.text,
              style: Theme.of(context).textTheme.body1,
              maxLines: 3,
            ),
            padding: EdgeInsets.only(bottom: 20.0),
          ),
          Container(
            child: Row(
              children: <Widget>[
                SynchronizeButton(),
                SynchronizeInfo(data: this.data)
              ],
            ),
          )
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
    );
  }
}