import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_project/src/resources/localisation.dart';

class SaveButton extends StatelessWidget {
  final void Function() saveCallback;

  const SaveButton({Key key, @required this.saveCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        saveCallback();
        Navigator.pop(context);
      },
      child: Text(localize(SAVE, context)),
    );
  }
}