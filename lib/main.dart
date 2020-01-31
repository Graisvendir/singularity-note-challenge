import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/resources/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(RecieverAdapter());
  Hive.registerAdapter(NoteModelAdapter());
  final repository = Repository();
  final bloc = SettingsBloc(repository);
  ShakeDetector.autoStart(
    onPhoneShake: () {
      bloc.put(Settings.theme, !bloc.settings[Settings.theme].value);
    },
  );
  
  runApp(
    MultiProvider(
      child: App(),
      providers: [
        Provider.value(
          value: repository,
        ),
        Provider<SettingsBloc>(
          create: (context) {
            bloc.fetchSettings();
            return bloc;
          },
          dispose: (context, bloc) => bloc.dispose(),
        ),
      ],
    )
  );
}