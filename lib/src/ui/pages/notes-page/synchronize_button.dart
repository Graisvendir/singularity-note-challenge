import 'package:flutter/material.dart';

class SynchronizeButton extends StatefulWidget {
  @override
  SynchronizeButtonState createState() => SynchronizeButtonState();
}

class SynchronizeButtonState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO rotate icon on synchronize
    return Container(
      child: Icon(Icons.update, size: 20.0),
      padding: EdgeInsets.only(right: 20.0),
    );
  }
}