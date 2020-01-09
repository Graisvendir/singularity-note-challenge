import 'package:flutter/material.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/resources/repository.dart';
import 'package:note_project/src/ui/pages/new_note_page.dart';
import 'package:note_project/src/ui/pages/notes_page.dart';
import 'package:provider/provider.dart';
import 'blocks/notes_block.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
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

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1);
  
    final repository = Provider.of<Repository>(context, listen: false);
    bloc = MainBloc(repository);
    bloc.fetchAllNotes();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: bloc,
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            controller: pageController,
            children: <Widget>[
              Container(),
              NewNotesPage(),
              NotesPage(),
            ],
          )
        ),
      ),
    );
  }
}