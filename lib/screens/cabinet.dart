import 'package:flutter/material.dart';

class Cabinet extends StatefulWidget {
  @override
  _CabinetState createState() => _CabinetState();
}

class _CabinetState extends State<Cabinet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Cabinet',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),),
    );
  }
}
