import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';
import 'package:note_project/src/constants.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/models/settings.dart';
import 'package:note_project/src/resources/email.dart';
import 'package:uuid/uuid.dart';
import '../../blocks/notes_block.dart';
import 'package:provider/provider.dart';

class NewNotesPage extends StatefulWidget {
  @override
  _NewNotesPageState createState() => _NewNotesPageState();
}

class _NewNotesPageState extends State<NewNotesPage> {
  File _image;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void clear() {
    removeImage();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SettingsBloc>(context);
    final mainBloc = Provider.of<MainBloc>(context);
    print(bloc.getRecievers());

    double startDrag;
    double updateDrag;
    return  GestureDetector(
      onVerticalDragStart: (DragStartDetails dragStartDetails) {
       startDrag = dragStartDetails.globalPosition.dy;
      },
      onVerticalDragUpdate: (DragUpdateDetails dragUpdateDetails) {
       updateDrag = dragUpdateDetails.globalPosition.dy;
      },
       onVerticalDragEnd: (DragEndDetails dragEndDetails) {
      if (startDrag - updateDrag < 0) {
        clear();
      } else {
        Sender.sendEmail(bloc.getRecievers(), _controller.value.text, _image);
        mainBloc.put(
          NoteModel()
          ..text = _controller.value.text
          ..key = Uuid().v4()
          ..imgPath = _image?.path
          ..dateCreated = DateTime.now()
          ..recievers = bloc.getRecieversBool()
        );
          
        clear();
      }
      },
      child: 
      Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                autofocus: true,
                cursorColor: Color(0x000),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Please, enter a lot of text'
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              )
            ),
            Container(
              child: _image == null
                  ? IconButton(
                    icon: Icon(
                      Icons.add, 
                      size: 50.0, 
                      color: Color(COLOR_GRAY)
                    ),
                    onPressed: getImage,
                  )
                  : Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        child: GestureDetector(
                          onTap: getImage,
                          child: Image.file(
                            _image, 
                            width: IMAGE_WIDTH, 
                            height: IMAGE_HEIGHT
                          )
                        ),
                      ),
                      Positioned(
                        top: -14.0,
                        left: -14.0,
                        child: GestureDetector(
                          onTap: removeImage,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              radius: 14.0,
                              backgroundColor: Color(COLOR_GRAY),
                              child: Icon(Icons.close, color: Color(COLOR_WHITE)),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
            ),
          ]
        ),
        padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
      )
    );
  }
  
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void removeImage() {
    setState(() {
      _image = null;
    });
  }
}

