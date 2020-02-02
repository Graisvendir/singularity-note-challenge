import 'package:flutter/material.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/resources/validation.dart';
import 'package:note_project/src/ui/pages/settings_props/delete_sync.dart';
import 'package:note_project/src/ui/pages/settings_props/save_button.dart';
import 'package:provider/provider.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';
import 'package:note_project/src/resources/localisation.dart';


class SingularitySettingsPage extends StatefulWidget {
  @override
  _SingularitySettingsPageState createState() => _SingularitySettingsPageState();
}

class _SingularitySettingsPageState extends State<SingularitySettingsPage> {
  bool _autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool checkValue = false;
  TextEditingController singularityLoginController;
  TextEditingController singularityPassController;

  @override
  void initState() {
    super.initState();
    final bloc = Provider.of<SettingsBloc>(context, listen: false);
    singularityLoginController = TextEditingController();
    singularityPassController = TextEditingController();

    bloc.fetchSettings().then((value) {
      singularityLoginController.text = bloc.settings[Settings.singLogin].value;
      singularityPassController.text = bloc.settings[Settings.singPass].value;
    });
  }
  String validateField(String value) {
    return validateEmail(value, context);
  }
  String validateTokenField(String value) {
    return validateToken(value, context);
  }

  @override
  void dispose() {
    singularityLoginController.dispose();
    singularityPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SettingsBloc>(context, listen: false);
    
    var provider = SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                children: <Widget>[
                  Text(localize(SING_SETTINGS, context)),
                  //логин
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: validateField,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: singularityLoginController,
                  ),
                  // токен
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: validateTokenField,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: singularityPassController,
                  ),  
                  StreamBuilder(
                    stream: bloc.settings[Settings.alwaysSyncSIngularity],
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Container();
                      return CheckboxListTile(
                        title: Text(localize(ALWAYS_SYNC, context)),
                        value: snapshot.data,
                        onChanged: (bool value) {
                            bloc.put(Settings.alwaysSyncSIngularity, value);
                        },
                      );
                    }
                  )
                ],
              ),
            ),
            SaveButton(
              saveCallback: _validateInputs
            ),
            DeleteSync(
              deleteCallback: () {
                singularityLoginController.clear();
                bloc.put(Settings.singLogin, singularityLoginController.value.text);
                singularityPassController.clear();
                bloc.put(Settings.singPass, singularityPassController.value.text);
              }
            )
          ],
        ),
      ),
    );
    return provider;
  }
  Future<void> _validateInputs() async {
    if (_formKey.currentState.validate()) {
      final bloc = Provider.of<SettingsBloc>(context, listen: false);
      await bloc.put(Settings.singLogin, singularityLoginController.value.text);
      await bloc.put(Settings.singPass, singularityPassController.value.text);
      Navigator.pop(context);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}