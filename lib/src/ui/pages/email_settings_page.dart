import 'dart:async';
import 'package:hive/hive.dart';

import 'package:flutter/material.dart';
import 'package:note_project/src/blocks/notes_block.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EmailSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of<MainBloc>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            EmailSettings(),
            SaveButton(),
            Expanded(
              child: FittedBox(
                fit: BoxFit.contain, // otherwise the logo will be tiny
                child: const FlutterLogo(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SaveButton extends StatefulWidget {
  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Save'),
    );
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
    return Column(
      children: <Widget>[
        Text('Email Setting'),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ), Checkbox(
          value: checkValue,
            onChanged: (bool value) {
                setState(() {
                    checkValue = value;
                });
            },
        )
      ],
    );
  }
}