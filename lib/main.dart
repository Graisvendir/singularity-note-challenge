import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/resources/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(RecieverAdapter());
  Hive.registerAdapter(NoteModelAdapter());
  final repository = Repository();
  
  runApp(
    Provider.value(
      child: App(),
      value: repository
    )
  );
}