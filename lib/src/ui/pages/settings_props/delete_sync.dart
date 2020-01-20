import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteSync extends StatefulWidget {
  @override
  _DeleteSyncState createState() => _DeleteSyncState();
}

class _DeleteSyncState extends State<DeleteSync> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Delete this sync'),
    );
  }
}