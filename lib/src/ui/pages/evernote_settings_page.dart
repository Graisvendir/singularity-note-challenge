import 'package:flutter/material.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/ui/pages/settings_props/delete_sync.dart';
import 'package:note_project/src/ui/pages/settings_props/save_button.dart';
import 'package:provider/provider.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';
import 'package:note_project/src/resources/localisation.dart';


class EvernoteSettingsPage extends StatefulWidget {
  @override
  _EvernoteSettingsPageState createState() => _EvernoteSettingsPageState();
}

class _EvernoteSettingsPageState extends State<EvernoteSettingsPage> {
  bool checkValue = false;
  TextEditingController evernoteController;

  @override
  void initState() {
    super.initState();
    final bloc = Provider.of<SettingsBloc>(context, listen: false);
    evernoteController = TextEditingController();

    bloc.fetchSettings().then((value) {
      evernoteController.text = bloc.settings[Settings.evernote].value;
    });
  }

   @override
    void dispose() {
    evernoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SettingsBloc>(context, listen: false);
    
    var provider = SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(localize(EVERNOTE_SETTINGS, context)),
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
                    return CheckboxListTile(
                      title: Text(localize(ALWAYS_SYNC, context)),
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
            DeleteSync(
              deleteCallback: () {
                evernoteController.clear();
                bloc.put(Settings.evernote, evernoteController.value.text);
              }
            )
          ],
        ),
      ),
    );
    return provider;
  }
}