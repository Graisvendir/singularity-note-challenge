import 'package:flutter/material.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:provider/provider.dart';
import 'package:note_project/src/resources/localisation.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool themeValue = false;
  
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SettingsBloc>(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                OpenSingularitySettings(),
                OpenEmailSettings(),
                OpenEvernoteSettings(),
                StreamBuilder(
                  stream: bloc.settings[Settings.theme],
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    
                      return CheckboxListTile(
                      title: Text(localize(LIGHT_THEME, context)),
                      value: snapshot.data,
                      onChanged: (bool value) {
                        bloc.put(Settings.theme, value);
                      },
                    );
                  }
                )
              ],
            )
          ), 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
            child: Material(
              color: Colors.red,
              child: InkWell(
                onTap: () async {
                  const url = 'https://play.google.com/store/apps/details?id=com.sibirix.singularityapp';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(localize(SING_APP_TRY_NOW, context)),
                      Text(localize(AVAILABLE, context)),
                    ]
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}

class OpenEmailSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.add_circle_outline, //adjust
            size: 23.0,
          ),
          Container(
            child: Text('Email'),
            padding: EdgeInsets.only(left: 30.0),
          )
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/emailSettings',
        );
      },
    );
  }
}

class OpenEvernoteSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.add_circle_outline, //adjust
            size: 23.0,
          ),
          Container(
            child: Text('Evernote'),
            padding: EdgeInsets.only(left: 30.0),
          )
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/evernoteSettings',
        );
      },
    );
  }
}

class OpenSingularitySettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.add_circle_outline, //adjust
            size: 23.0,
          ),
          Container(
            child: Text('Singularity App'),
            padding: EdgeInsets.only(left: 30.0),
          )
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/singularitySettings',
        );
      },
    );
  }
}