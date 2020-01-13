import 'dart:async';
import 'package:hive/hive.dart';

import 'package:flutter/material.dart';
import 'package:note_project/src/blocks/notes_block.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/ui/pages/email_settings_page.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // final bloc = Provider.of<MainBloc>(context);

    return Column(
      children: <Widget>[
        Text('SingularityApp'),
        OpenEmailSettings(),
        Text('Evernote'),
        Expanded(
          child: FittedBox(
            fit: BoxFit.contain, // otherwise the logo will be tiny
            child: const FlutterLogo(),
          ),
        ),
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