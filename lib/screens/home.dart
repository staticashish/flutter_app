import 'package:flutter/material.dart';
import 'package:flutter_app/screens/custom/left_navigation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftNavigation(),
      appBar: AppBar(
        backgroundColor: Color(0Xff5f72a9),
        elevation: 10.0,
        title: Text('Home'),
      ),
      //drawer: LeftNavigation(),
      body: Center(
        child: Container(
          child: Text(
            "Home",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}
