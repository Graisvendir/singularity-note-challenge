import 'package:flutter/material.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/resources/repository.dart';
import 'package:note_project/src/ui/pages/settings_props/delete_sync.dart';
import 'package:note_project/src/ui/pages/settings_props/save_button.dart';
import 'package:provider/provider.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';

class EmailSettingsPage extends StatefulWidget {
  @override
  _EmailSettingsPageState createState() => _EmailSettingsPageState();
}

class _EmailSettingsPageState extends State<EmailSettingsPage> {

  bool checkValue = false;
  TextEditingController emailController;
  SettingsBloc bloc;

  @override
  void initState() {
    super.initState();
    final repository = Provider.of<Repository>(context, listen: false);
    bloc = SettingsBloc(repository);
    emailController = TextEditingController();

    bloc.fetchSettings().then((value) {
      emailController.text = bloc.settings[Settings.email].value;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.value(
      value: bloc,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Email Setting'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: emailController,
                  ), 
                  StreamBuilder(
                    stream: bloc.settings[Settings.alwaysSyncEmail],
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Container();
                      return Checkbox(
                        value: snapshot.data,
                        onChanged: (bool value) {
                            bloc.put(Settings.alwaysSyncEmail, value);
                        },
                      );
                    }
                  )
                ],
              ),
              SaveButton(
                saveCallback: () {
                  bloc.put(Settings.email, emailController.value.text);
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