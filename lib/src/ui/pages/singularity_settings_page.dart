import 'package:flutter/material.dart';
import 'package:note_project/src/ui/pages/settings_props/delete_sync.dart';
import 'package:note_project/src/ui/pages/settings_props/save_button.dart';

class SingularitySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of<MainBloc>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SettingsElements(),
            SaveButton(),
            DeleteSync()
          ],
        ),
      ),
    );
  }
}

class SettingsElements extends StatefulWidget {

  @override
  _SingularitySettingsState createState() => _SingularitySettingsState();
}

class _SingularitySettingsState extends State<SettingsElements> {

  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Singularity App Setting'),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
         
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          )
        ), 
        Checkbox(
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