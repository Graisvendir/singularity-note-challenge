import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_project/src/resources/localisation.dart';

class DeleteSync extends StatelessWidget {
  final void Function() deleteCallback;

  const DeleteSync({ @required this.deleteCallback}) : super();

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        deleteCallback();
        Navigator.pop(context);
      },
      child: Text(localize(DELETE_SYNC, context)),
    );
  }
}