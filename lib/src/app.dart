import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';
import 'package:note_project/src/constants.dart';
import 'package:note_project/src/resources/repository.dart';
import 'package:note_project/src/ui/pages/email_settings_page.dart';
import 'package:note_project/src/ui/pages/evernote_settings_page.dart';
import 'package:note_project/src/ui/pages/new_note_page.dart';
import 'package:note_project/src/ui/pages/notes_page.dart';
import 'package:note_project/src/ui/pages/settings_page.dart';
import 'package:note_project/src/ui/pages/singularity_settings_page.dart';
import 'package:provider/provider.dart';
import 'blocks/notes_block.dart';
import 'constants.dart';
import 'models/settings.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SettingsBloc>(context);

    return StreamBuilder(
        stream: bloc.settings[Settings.theme],
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();

          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
                highlightColor: Color(0xff2b2c37),
                fontFamily: 'HelveticaNeue-Light',
                textTheme: TextTheme(
                    body1: TextStyle(fontSize: 14.0, color: Color(COLOR_GRAY)),
                    body2: TextStyle(
                        fontSize: 12.0, color: Color(COLOR_LIGHT_GRAY)))),
            darkTheme:
                ThemeData.dark().copyWith(highlightColor: Color(0xff75899b)),
            themeMode: snapshot.data ? ThemeMode.light : ThemeMode.dark,
            initialRoute: '/',
            routes: {
              '/': (context) => MainPage(),
              EMAIL_SETTINGS_PATH: (context) => EmailSettingsPage(),
              EVERNOTE_SETTINGS_PATH: (context) => EvernoteSettingsPage(),
              SINGULARITY_SETTINGS_PATH: (context) => SingularitySettingsPage()
            },
            supportedLocales: [
              const Locale('en'), // English
              const Locale('ru'), // Russian
            ],
          );
        });
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController;
  TextEditingController textController;
  MainBloc bloc;
  File image;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1);
    textController = TextEditingController();

    final repository = Provider.of<Repository>(context, listen: false);
    bloc = MainBloc(repository);
    bloc.fetchAllNotes();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    textController.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: bloc),
      ],
      child: Scaffold(
          body: SafeArea(
              child: PageView(
        controller: pageController,
        children: <Widget>[
          SettingsPage(),
          NewNotesPage(
            pageController: pageController,
            controller: textController,
            setImage: (f) {
              setState(() {
                image = f;
              });
            },
            image: image,
          ),
          NotesPage(),
        ],
      ))),
    );
  }
}
