import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/cabinet.dart';
import 'package:flutter_app/screens/custom/bottom_navigation.dart';
import 'package:flutter_app/screens/custom/custom_list_tile.dart';
import 'package:flutter_app/screens/custom/left_navigation.dart';
import 'package:flutter_app/screens/room.dart';
import 'file:///C:/Nisha/projects/mobile-app/flutter_app/lib/screens/search.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'file:///C:/Nisha/projects/mobile-app/flutter_app/lib/screens/thing.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> widgetOptions = <Widget>[
    Room(),
    Cabinet(),
    Thing(),
    Search()
  ];


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0Xff5f72a9),
          elevation: 10.0,
          title: Text('Flutter Demo'),
        ),
        body: Center(
          child: widgetOptions[_selectedIndex],
        ),
        drawer: LeftNavigation(),
        bottomNavigationBar: BottomNavigation(index : _selectedIndex, onTapFunction: _onItemTapped),

    );
  }
}
