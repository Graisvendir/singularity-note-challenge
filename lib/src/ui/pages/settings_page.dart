import 'dart:async';
import 'package:hive/hive.dart';

import 'package:flutter/material.dart';
import 'package:note_project/src/blocks/notes_block.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/ui/pages/email_settings_page.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

enum SettingName { email }

class _SettingsPageState extends State<SettingsPage> {
  bool themeValue = false;
  
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SettingsBloc>(context);

    return Column(
      children: <Widget>[
        Text('SingularityApp'),
        OpenEmailSettings(),
        Text('Evernote'),
       StreamBuilder<Settings>(
         stream: bloc.settings,
         builder: (context, snapshot) {
           if (!snapshot.hasData) {
             return Container();
           }

           return Checkbox(
              value: snapshot.data.theme,
                onChanged: (bool value) {
                  final newSettings = snapshot.data;
                  newSettings.theme = value;

                  bloc.put(newSettings);
                },
            );
         }
       )
      ],
    );
  }
}

class OpenEmailSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
          Navigator.pushNamed(
            context,
            '/emailSettings',
          );
      },
      child: Text('Email'),
    );
  }
}