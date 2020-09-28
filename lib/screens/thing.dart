import 'package:flutter/material.dart';

class Thing extends StatefulWidget {
  @override
  _ThingState createState() => _ThingState();
}

class _ThingState extends State<Thing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Thing',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
