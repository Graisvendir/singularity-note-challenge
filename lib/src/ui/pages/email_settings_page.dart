import 'package:flutter/material.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/ui/pages/settings_props/delete_sync.dart';
import 'package:note_project/src/ui/pages/settings_props/save_button.dart';
import 'package:provider/provider.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';
import 'package:note_project/src/resources/localisation.dart';

class EmailSettingsPage extends StatefulWidget {
  @override
  _EmailSettingsPageState createState() => _EmailSettingsPageState();
}

class _EmailSettingsPageState extends State<EmailSettingsPage> {

  bool checkValue = false;
  TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    final bloc = Provider.of<SettingsBloc>(context, listen: false);
    emailController = TextEditingController();

    bloc.fetchSettings().then((value) {
      emailController.text = bloc.settings[Settings.email].value;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SettingsBloc>(context, listen: false);

    var provider = SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(
            vertical: 40.0, 
            horizontal: 30.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(localize(EMAIL_SETTINGS, context)),
                padding: EdgeInsets.only(
                  bottom: 15.0
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: localize(EMAIL_SETTINGS, context)
                ),
                controller: emailController,
              ), 
              StreamBuilder(
                stream: bloc.settings[Settings.alwaysSyncEmail],
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();
                  
                  return CheckboxListTile(
                    title: Text(localize(ALWAYS_SYNC, context)),
                    value: snapshot.data,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (bool value) {
                      bloc.put(Settings.alwaysSyncEmail, value);
                    },
                  );
                }
              ),
              SaveButton(
                saveCallback: () {
                  bloc.put(Settings.email, emailController.value.text);
                },
              ),
              DeleteSync(
                deleteCallback: () {
                  emailController.clear();
                  bloc.put(Settings.email, emailController.value.text);
                }
              )
            ],
          ),
        )
          
      ),
    );

    return provider;
  }
}