import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_project/src/models/note_model.dart';
import '../../../constants.dart';
import '../../../models/note_model.dart';

class OneNote extends StatefulWidget {

  final NoteModel data;
  OneNote({NoteModel data}): this.data = data;

  OneNoteState createState() => OneNoteState(data);
}

class OneNoteState extends State<OneNote> {
  
  final NoteModel data;
  double _opacity = 0.5;
  OneNoteState(this.data);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: synchronize,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 5),
        opacity: this._opacity,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
                      child: Icon(Icons.update, size: 20.0),
                      padding: EdgeInsets.only(right: 20.0),
                    ),
                    Text(
                      this.synchronisationInfo(this.data.dateCreated, this.data.recievers),
                      style: Theme.of(context).textTheme.body2,  
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  void synchronize() {
    // TODO make synchrinization
    print('synchronize note');
    setState(() {
      _opacity = 1;
    });
  }

  String synchronisationInfo(DateTime date, Reciever accounts) {
    String row = '';

    var formatter = new DateFormat('d MMMM y', Localizations.localeOf(context).languageCode);
    row = formatter.format(date);

    if (accounts.email) {
      row += ' / ' + EMAIL_CAPTION;
    }

    if (accounts.evernote) {
      row += ' / ' + EVERNOTE_CAPTION;
    }

    if (accounts.singularityApp) {
      row += ' / ' + SINGULARITY_APP_CAPTION;
    }

    return row;
  }
}