import 'package:flutter/material.dart';
import 'package:note_project/src/ui/pages/settings_props/save_button.dart';

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