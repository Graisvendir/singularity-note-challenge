import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_project/src/resources/email.dart';

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

  @override
  Widget build(BuildContext context) {
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
      if(startDrag - updateDrag < 0) {
         _controller.clear();
      } else {
         sendEmail();
      }
      },
      child: 
      Column(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
              border: InputBorder.none
            ),
            
          )
          ),
          Center(
            child: _image == null
                ? new Text('No image selected.')
                : new Image.file(_image),
          ),
  
          FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: new Icon(Icons.add_a_photo),
          ),
        ],
      )
      
    );
  }
  Future getImage() async {
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
    _image = image;
  });
}
}

