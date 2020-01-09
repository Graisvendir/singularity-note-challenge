import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewNotesPage extends StatefulWidget {
  @override
  _NewNotesPageState createState() => _NewNotesPageState();
}

class _NewNotesPageState extends State<NewNotesPage> {
  File _image;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = new TextEditingController();
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
      }
      },
      child: 
      Column(
        children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
              border: InputBorder.none
            ),
            
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

