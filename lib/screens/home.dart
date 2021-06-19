import 'package:flutter/material.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
import 'package:flutter_app/screens/navigation/left_navigation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
      ),
      drawer: LeftNavigation(),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                child: Text(
                  "Home",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
