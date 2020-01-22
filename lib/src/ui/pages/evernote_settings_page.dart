import 'package:flutter/material.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/resources/repository.dart';
import 'package:note_project/src/ui/pages/settings_props/delete_sync.dart';
import 'package:note_project/src/ui/pages/settings_props/save_button.dart';
import 'package:provider/provider.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';

class EvernoteSettingsPage extends StatefulWidget {
  @override
  _EvernoteSettingsPageState createState() => _EvernoteSettingsPageState();
}

class _EvernoteSettingsPageState extends State<EvernoteSettingsPage> {
  bool checkValue = false;
  TextEditingController evernoteController;
  SettingsBloc bloc;

  @override
  void initState() {
    super.initState();
    final repository = Provider.of<Repository>(context, listen: false);
    bloc = SettingsBloc(repository);
    evernoteController = TextEditingController();

    bloc.fetchSettings().then((value) {
      evernoteController.text = bloc.settings[Settings.evernote].value;
    });
  }

   @override
    void dispose() {
    evernoteController.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.value(
      value: bloc,
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Evernote Setting'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: evernoteController,
                  ), 
                  StreamBuilder(
                    stream: bloc.settings[Settings.alwaysSyncEvernote],
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Container();
                      return Checkbox(
                        value: snapshot.data,
                        onChanged: (bool value) {
                            bloc.put(Settings.alwaysSyncEvernote, value);
                        },
                      );
                    }
                  )
                ],
              ),
              SaveButton(
                saveCallback: () {
                  bloc.put(Settings.evernote, evernoteController.value.text);
                },
              ),
              DeleteSync()
            ],
          ),
        ),
      )
    );
    return provider;
  }
}