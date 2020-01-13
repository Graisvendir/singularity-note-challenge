import 'package:flutter/material.dart';
import 'package:note_project/src/models/note_model.dart';

class SynchronizeInfo extends StatefulWidget {
  final NoteModel data;
  SynchronizeInfo({NoteModel data}): this.data = data;

  SynchronizeInfoState createState() => SynchronizeInfoState(data);
}

class SynchronizeInfoState extends State<SynchronizeInfo> {
  
  final NoteModel data;
  SynchronizeInfoState(this.data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String result = this.data.dateCreated.toString();
    return Text(result);
  }
}