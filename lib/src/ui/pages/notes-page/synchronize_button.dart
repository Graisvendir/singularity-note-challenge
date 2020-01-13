import 'package:flutter/material.dart';

class SynchronizeButton extends StatefulWidget {
  @override
  SynchronizeButtonState createState() => SynchronizeButtonState();
}

class SynchronizeButtonState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.update, size: 20.0),
        onPressed: () {
          // TODO: synchronize note function call
          print('synchronize note');
        },
      )
    );
  }
}