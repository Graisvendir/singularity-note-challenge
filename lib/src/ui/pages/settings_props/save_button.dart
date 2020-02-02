import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_project/src/resources/localisation.dart';
import 'package:email_validator/email_validator.dart';

class SaveButton extends StatelessWidget {
  final void Function() saveCallback;

  const SaveButton({Key key, @required this.saveCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        saveCallback();
      },
      child: Text(localize(SAVE, context)),
      
    );
  }
}