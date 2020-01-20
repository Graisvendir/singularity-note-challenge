import 'dart:async';
import 'package:hive/hive.dart';

import 'package:flutter/material.dart';
import 'package:note_project/src/blocks/notes_block.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/resources/settings_provider.dart';
import 'package:note_project/src/ui/pages/email_settings_page.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool themeValue = false;
  
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SettingsBloc>(context);

    return Column(
      children: <Widget>[
        OpenSingularitySettings(),
        OpenEmailSettings(),
        OpenEvernoteSettings(),
        StreamBuilder(
          stream: bloc.settings[Settings.theme],
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            
            return Checkbox(
                value: snapshot.data,
                  onChanged: (bool value) {
                    bloc.put(Settings.theme, value);
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
class OpenEvernoteSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
          Navigator.pushNamed(
            context,
            '/evernoteSettings',
          );
      },
      child: Text('Evernote'),
    );
  }
}
class OpenSingularitySettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
          Navigator.pushNamed(
            context,
            '/singularitySettings',
          );
      },
      child: Text('Singularity App'),
    );
  }
}