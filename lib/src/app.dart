import 'package:flutter/material.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';
import 'package:note_project/src/constants.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/resources/repository.dart';
import 'package:note_project/src/ui/pages/email_settings_page.dart';
import 'package:note_project/src/ui/pages/new_note_page.dart';
import 'package:note_project/src/ui/pages/notes_page.dart';
import 'package:note_project/src/ui/pages/settings_page.dart';
import 'package:provider/provider.dart';
import 'blocks/notes_block.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'HelveticaNeue-Light',
        textTheme: TextTheme(
          body1: TextStyle(fontSize: 18.0)
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        EMAIL_SETTINGS_PATH: (context) => EmailSettingsPage(),
        EVERNOTE_SETTINGS_PATH: (context) => EmailSettingsPage(),
        SINGULARITY_SETTINGS_PATH: (context) => EmailSettingsPage()
      },
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController;
  MainBloc bloc;
  SettingsBloc settingsBloc;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1);
  
    final repository = Provider.of<Repository>(context, listen: false);
    bloc = MainBloc(repository);
    bloc.fetchAllNotes();

    settingsBloc = SettingsBloc(repository);
    settingsBloc.fetchSettings();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    bloc.dispose();
    settingsBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: bloc),
        Provider.value(value: settingsBloc),
      ],
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            controller: pageController,
            children: <Widget>[
              SettingsPage(),
              NewNotesPage(),
              NotesPage(),
            ],
          )
        )
      ),
    );
  }
}