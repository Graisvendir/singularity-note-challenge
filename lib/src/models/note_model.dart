import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class Reciever extends HiveObject {
  @HiveField(0)
  bool email;

  @HiveField(1)
  bool evernote;

  @HiveField(2)
  bool singularityApp;
}

@HiveType(typeId: 1)
class NoteModel extends HiveObject {
  @HiveField(0)
  String key;

  @HiveField(1)
  String text;

  @HiveField(2)
  String imgPath;

  @HiveField(3)
  List<Reciever> recieverList;

  @HiveField(4)
  DateTime dateCreated;
}