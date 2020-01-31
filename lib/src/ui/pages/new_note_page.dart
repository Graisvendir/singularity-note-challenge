import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';
import 'package:note_project/src/constants.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/resources/email.dart';
import 'package:uuid/uuid.dart';
import '../../blocks/notes_block.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class NewNotesPage extends StatefulWidget {
  final PageController pageController;

  final TextEditingController controller;
  final File image;
  final void Function(File) setImage;

  const NewNotesPage({Key key, this.controller, this.setImage, this.image, this.pageController}) : super(key: key);

  @override
  _NewNotesPageState createState() => _NewNotesPageState();
}

class _NewNotesPageState extends State<NewNotesPage> {
  void clear() {
    removeImage();
    widget.controller.clear();
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
        //место для показа пальца вверх или вниз
        updateDrag = dragUpdateDetails.globalPosition.dy;
      },
      onVerticalDragEnd: (DragEndDetails dragEndDetails) async {
        if (startDrag - updateDrag < -40) {
          clear();
        } else if (startDrag - updateDrag > 40) {
          Reciever reciever = bloc.getRecieversBool();
          if(reciever.email == true || reciever.evernote == true || reciever.singularityApp == true) {
            final NoteModel note = NoteModel()
            ..text = widget.controller.value.text
            ..key = Uuid().v4()
            ..imgPath = widget.image?.path
            ..dateCreated = DateTime.now()
            ..recievers = reciever;

            clear();

            bool success = await Sender.sendEmail(bloc.getRecievers(), note);

            note.wasSentSuccessfully = success;

            mainBloc.put(note);
              
            
          } else {
            widget.pageController.jumpToPage(0);
          }
        }
      },
      child: 
      Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: widget.controller,
                autofocus: true,
                cursorColor: Color(0x000),
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              )
            ),
            Container(
              child: widget.image == null
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
                            widget.image, 
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
    if (image == null) {
      return;
    }

    widget.setImage(image);
  }

  void removeImage() {
    widget.setImage(null);
  }
}

