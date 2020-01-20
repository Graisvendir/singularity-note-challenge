import 'package:flutter/material.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/resources/repository.dart';
import 'package:note_project/src/ui/pages/settings_props/delete_sync.dart';
import 'package:note_project/src/ui/pages/settings_props/save_button.dart';
import 'package:provider/provider.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';

class EmailSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context);

    var provider = Provider<SettingsBloc>(
      create: (context) => SettingsBloc(repository)..fetchSettings(),
      dispose: (context, bloc) => bloc.dispose(),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              EmailSettings(),
              SaveButton(),
              DeleteSync()
            ],
          ),
        ),
      )
    );
    return provider;
  }
}

class EmailSettings extends StatefulWidget {

  @override
  _EmailSettingsState createState() => _EmailSettingsState();
}

class _EmailSettingsState extends State<EmailSettings> {

  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
   final settingsBloc = Provider.of<SettingsBloc>(context);
   
    return Column(
      children: <Widget>[
        Text('Email Setting'),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ), 
        StreamBuilder(
          stream: settingsBloc.settings[Settings.alwaysSyncEmail],
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            return Checkbox(
              value: snapshot.data,
              onChanged: (bool value) {
                  settingsBloc.put(Settings.alwaysSyncEmail, value);
              },
            );
          }
        )
      ],
    );
  }
}