import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet.dart';
import 'package:flutter_app/screens/custom/bottom_navigation.dart';
import 'package:flutter_app/screens/custom/left_navigation.dart';
import 'package:flutter_app/screens/room/room.dart';
import 'package:flutter_app/screens/search.dart';
import 'package:flutter_app/screens/thing.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/database_service.dart';
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
    });
  }

  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> widgetOptions = <Widget>[Room(), Cabinet(), Thing(), Search()];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MultiProvider(
        providers: [
          StreamProvider<List<RoomModel>>.value(
              value: DatabaseService(uid: user.uid).rooms),
          StreamProvider<List<CabinetModel>>.value(
              value: DatabaseService(uid: user.uid).cabinets),
        ],
        child: Scaffold(
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
          bottomNavigationBar: BottomNavigation(
              index: _selectedIndex, onTapFunction: _onItemTapped),
        ));
  }
}
