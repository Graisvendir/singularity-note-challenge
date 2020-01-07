import 'package:flutter/material.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/resources/repository.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'blocks/notes_block.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage()
      },
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  NotesBloc bloc;
  
  @override
  void initState() {
    super.initState();
  
    final repository = Provider.of<Repository>(context, listen: false);
    bloc = NotesBloc(repository);
    bloc.fetchAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: bloc,
      child: Scaffold(
        body: Column(
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
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        final bloc = Provider.of<NotesBloc>(context, listen: false);
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

// Scaffold(
//         body: SafeArea(
//           child: Column(
//             children: <Widget>[
//               MaterialButton(
//                 onPressed: () {
//                   final repo = Provider.of<Repository>(context, listen: false);
//                   NoteModel note = NoteModel()
//                     ..key = Uuid().v4()
//                     ..imgPath = 'imgPath'
//                     ..recieverList = [Reciever()..email = true..evernote = false..singularityApp = false]
//                     ..text = 'text';
//                   repo.notesProvider.put(note);
//                   print(repo);
//                 },
//                 child: Text('put'),
//               ),
//               MaterialButton(
//                 onPressed: () {
//                   final repo = Provider.of<Repository>(context, listen: false);
//                   final notes = repo.notesProvider.fetchAllNotes();
//                   print(notes);
//                 },
//                 child: Text('fetch'),
//               ),
//             ],
//           ),
//         ),
//       ),