import 'package:flutter/material.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/resources/repository.dart';
import 'package:note_project/src/ui/pages/settings_props/delete_sync.dart';
import 'package:note_project/src/ui/pages/settings_props/save_button.dart';
import 'package:provider/provider.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';

class SingularitySettingsPage extends StatefulWidget {
  @override
  _SingularitySettingsPageState createState() => _SingularitySettingsPageState();
}

class _SingularitySettingsPageState extends State<SingularitySettingsPage> {

  bool checkValue = false;
  TextEditingController singularityLoginController;
  TextEditingController singularityPassController;
  SettingsBloc bloc;

  @override
  void initState() {
    super.initState();
    final repository = Provider.of<Repository>(context, listen: false);
    bloc = SettingsBloc(repository);
    singularityLoginController = TextEditingController();
    singularityPassController = TextEditingController();

    bloc.fetchSettings().then((value) {
      singularityLoginController.text = bloc.settings[Settings.singLogin].value;
      singularityPassController.text = bloc.settings[Settings.singPass].value;
    });
  }

  @override
  void dispose() {
    singularityLoginController.dispose();
    singularityPassController.dispose();
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
                  Text('SingularityApp Setting'),
                  //логин
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: singularityLoginController,
                  ),
                  // пароль пока не делаем, не понятно что будет
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: singularityPassController,
                  ),  
                  StreamBuilder(
                    stream: bloc.settings[Settings.alwaysSyncSIngularity],
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Container();
                      return Checkbox(
                        value: snapshot.data,
                        onChanged: (bool value) {
                            bloc.put(Settings.alwaysSyncSIngularity, value);
                        },
                      );
                    }
                  )
                ],
              ),
              SaveButton(
                saveCallback: () {
                  bloc.put(Settings.singLogin, singularityLoginController.value.text);
                  bloc.put(Settings.singPass, singularityPassController.value.text);
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