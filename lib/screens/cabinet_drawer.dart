import 'package:flutter/material.dart';
import 'package:flutter_app/screens/custom/left_navigation.dart';

class CabinetDrawer extends StatefulWidget {
  @override
  _CabinetDrawerState createState() => _CabinetDrawerState();
}

class _CabinetDrawerState extends State<CabinetDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftNavigation(),
      appBar: AppBar(
        backgroundColor: Color(0Xff5f72a9),
        elevation: 10.0,
        title: Text('Drawer'),
      ),
      //drawer: LeftNavigation(),
      body: Center(
        child: Container(
          child: Text(
            "Drawer",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Add Drawer");
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0Xff5f72a9),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
