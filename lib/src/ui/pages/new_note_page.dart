import 'dart:io';
import 'package:flutter/material.dart';
import 'package:note_project/src/resources/localisation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_project/src/blocks/settings_bloc.dart';
import 'package:note_project/src/constants.dart';
import 'package:note_project/src/models/note_model.dart';
import 'package:note_project/src/resources/email.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import '../../blocks/notes_block.dart';
import '../../constants.dart';
import '../../resources/localisation.dart';

class NewNotesPage extends StatefulWidget {
  final PageController pageController;

  final TextEditingController controller;
  final File image;
  final void Function(File) setImage;

  const NewNotesPage(
      {Key key,
      this.controller,
      this.setImage,
      this.image,
      this.pageController})
      : super(key: key);

  @override
  _NewNotesPageState createState() => _NewNotesPageState();
}

class _NewNotesPageState extends State<NewNotesPage>
    with SingleTickerProviderStateMixin {
  FocusNode fn = FocusNode();
  Animation<double> _translationFinger;
  AnimationController _animationController;
  double _fingerPosition = 0.0;
  double _startSwipePosition = 0.0;
  double _delta = 0.0;

  void clear() {
    removeImage();
    widget.controller.clear();
  }

  @override
  void dispose() {
    fn.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
    );

    _animationController.addListener(() {
      setState(() {
        _fingerPosition = _translationFinger.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SettingsBloc>(context);
    final mainBloc = Provider.of<MainBloc>(context);

    return GestureDetector(
        onVerticalDragStart: (DragStartDetails details) {
          setState(() {
            _startSwipePosition = details.localPosition.dy;
          });
        },
        onVerticalDragUpdate: (DragUpdateDetails details) {
          if ((_startSwipePosition - details.localPosition.dy).abs() < 150.0) {
            setState(() {
              _fingerPosition += details.delta.dy;
            });
          }
        },
        onVerticalDragEnd: (DragEndDetails details) async {
          if (_fingerPosition > 0) {
            clear();
            setState(() {
              _fingerPosition = 0.0;
            });
          } else if (_fingerPosition < 0) {
            setState(() {
              _fingerPosition = 0.0;
            });
            Reciever reciever = bloc.getRecieversBool();
            if (reciever.email == true ||
                reciever.evernote == true ||
                reciever.singularityApp == true) {
              final NoteModel note = NoteModel()
                ..text = widget.controller.value.text
                ..key = Uuid().v4()
                ..imgPath = widget.image?.path
                ..dateCreated = DateTime.now()
                ..recievers = reciever;

              clear();

              bool success = await Sender.sendEveryWhere(
                  bloc.getRecievers(), note, bloc.getAuth());

              note.wasSentSuccessfully = success;

              mainBloc.put(note);
            } else {
              widget.pageController.jumpToPage(0);
            }
          }
        },
        child: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
            child:
                Column(children: <Widget>[makeTextInput(), makeImagePicker()]),
          ),
          Positioned(
              top: -100.0 + _fingerPosition,
              left: MediaQuery.of(context).size.width / 2 - 75.0,
              child: Opacity(
                  opacity: 0.5,
                  child: Container(
                      width: 150.0,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.pan_tool,
                            ),
                            Text(localize(SWIPE_DOWN, context),
                                textAlign: TextAlign.center)
                          ])))),
          Positioned(
              top: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewInsets.bottom +
                  _fingerPosition,
              left: MediaQuery.of(context).size.width / 2 - 75.0,
              child: Opacity(
                  opacity: 0.5,
                  child: Container(
                      width: 150.0,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.pan_tool,
                            ),
                            Text(localize(SWIPE_UP, context),
                                textAlign: TextAlign.center)
                          ])))),
        ]));
  }

  Widget makeTextInput() {
    return Expanded(
        child: TextField(
      controller: widget.controller,
      autofocus: true,
      focusNode: fn,
      cursorColor: Color(0x000),
      decoration: InputDecoration(border: InputBorder.none),
      keyboardType: TextInputType.multiline,
      maxLines: null,
    ));
  }

  Widget makeImagePicker() {
    final theme = Theme.of(context);

    return Container(
      child: widget.image == null
          ? IconButton(
              alignment: Alignment.center,
              iconSize: 50,
              icon: Icon(Icons.add, color: theme.textTheme.body1.color),
              onPressed: getImage,
            )
          : Stack(overflow: Overflow.visible, children: [
              Container(
                child: GestureDetector(
                    onTap: getImage,
                    child: Image.file(widget.image,
                        width: IMAGE_WIDTH, height: IMAGE_HEIGHT)),
              ),
              Positioned(
                top: -14.0,
                left: -14.0,
                child: InkWell(
                  onTap: removeImage,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.close, color: Color(COLOR_WHITE)),
                    decoration: BoxDecoration(
                        color: Color(COLOR_GRAY),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                ),
              ),
            ]),
    );
  }

  Future getImage() async {
    fn.unfocus();
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    widget.setImage(image);
  }

  Future<void> pickImageFromGallery() async {
    Navigator.pop(
        context, await ImagePicker.pickImage(source: ImageSource.gallery));
  }

  Future<void> pickImageFromCamera() async {
    Navigator.pop(
        context, await ImagePicker.pickImage(source: ImageSource.camera));
  }

  Future<void> showChoiceDialog(BuildContext context) async {
    fn.unfocus();

    final path = await showDialog<File>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Text(localize(CAMERA, context),
                      textAlign: TextAlign.center),
                  onTap: pickImageFromCamera,
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Text(
                    localize(GALLERY, context),
                    textAlign: TextAlign.center,
                  ),
                  onTap: pickImageFromGallery,
                ),
              )
            ],
          ));
        });

    if (path == null) {
      return;
    }

    widget.setImage(path);
  }

  void removeImage() {
    widget.setImage(null);
  }
}
