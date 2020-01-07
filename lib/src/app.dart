import 'package:flutter/material.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/resources/repository.dart';
import 'package:note_project/src/ui/pages/new_note_page.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<MainBloc>(context);

    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<List<NoteModel>>(
            stream: bloc.allNotes,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView(
                children: snapshot.data.map((n) => Text(n.key)).toList(),
              );
            },
          ),
        ),
        AddButton(),
      ],
    );
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        final bloc = Provider.of<MainBloc>(context, listen: false);
        NoteModel note = NoteModel()
          ..key = Uuid().v4()
          ..imgPath = 'imgPath'
          ..recieverList = [Reciever()..email = true..evernote = false..singularityApp = false]
          ..text = 'text';
        bloc.put(note);
      },
      child: Text('add'),
    );
  }
}