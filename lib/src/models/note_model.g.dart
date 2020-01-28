// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecieverAdapter extends TypeAdapter<Reciever> {
  @override
  final typeId = 0;

  @override
  Reciever read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reciever()
      ..email = fields[0] as bool
      ..evernote = fields[1] as bool
      ..singularityApp = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, Reciever obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.evernote)
      ..writeByte(2)
      ..write(obj.singularityApp);
  }
}

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final typeId = 1;

  @override
  NoteModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel()
      ..key = fields[0] as String
      ..text = fields[1] as String
      ..imgPath = fields[2] as String
      ..recievers = fields[3] as Reciever
      ..dateCreated = fields[4] as DateTime
      ..wasSentSuccessfully = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.imgPath)
      ..writeByte(3)
      ..write(obj.recievers)
      ..writeByte(4)
      ..write(obj.dateCreated)
      ..writeByte(5)
      ..write(obj.wasSentSuccessfully);
  }
}
