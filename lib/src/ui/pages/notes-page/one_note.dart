import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_project/src/blocks/notes_block.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/resources/email.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../models/note_model.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';


class OneNote extends StatefulWidget {

  final NoteModel data;
  final SettingsBloc settingsBloc;
  OneNote({NoteModel data, this.settingsBloc}): 
  this.data = data;
  

  OneNoteState createState() => OneNoteState(data, settingsBloc);
}

class OneNoteState extends State<OneNote> {
  
  final NoteModel data;
  final SettingsBloc settingsBloc;
  OneNoteState(this.data, this.settingsBloc);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<MainBloc>(context);
    
    return InkWell(
      onTap: data.wasSentSuccessfully ? null : () => synchronize(bloc),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity: data.wasSentSuccessfully ? 1: 0.5,
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
                    Expanded(
                      child: Text(
                        this.synchronisationInfo(this.data.dateCreated, this.data.recievers),
                        style: Theme.of(context).textTheme.body2,  
                      ),
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

  void synchronize(MainBloc bloc) async{
    List<String> recipients = getRecipients(data.recievers);
    
    final auth = data.recievers.singularityApp ? settingsBloc.getAuth() : Auth('', ''); 
    bool success = await Sender.sendEveryWhere(recipients, data, auth);
    if (success) {
      data.wasSentSuccessfully = true;
      bloc.put(data);
    }
  }

  List<String> getRecipients(Reciever reciever) {
    final currentRecievers = this.settingsBloc.getRecievers();
    final currentBoolRecievers = this.settingsBloc.getRecieversBool();
    final List<String> thisNoteRecievers = [];
    if(currentBoolRecievers.email) {
      if(reciever.email == true) {
        thisNoteRecievers.add(currentRecievers[0]);
      }
      if(reciever.evernote == true && currentBoolRecievers.evernote) {
        thisNoteRecievers.add(currentRecievers[1]);
      }
    } else if (currentBoolRecievers.evernote) {
      if(reciever.evernote == true) {
        thisNoteRecievers.add(currentRecievers[0]);
      }
    }
    return thisNoteRecievers;
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