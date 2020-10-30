import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet.dart';
import 'package:flutter_app/screens/cabinet_drawer.dart';
import 'package:flutter_app/screens/navigation/bottom_navigation.dart';
import 'package:flutter_app/screens/room/room.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/item.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:provider/provider.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final AuthService _authService = AuthService();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> widgetOptions = <Widget>[Home(), Room(), Cabinet(), CabinetDrawer(), Item()];

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
          body: widgetOptions[_selectedIndex],
          bottomNavigationBar: BottomNavigation(
              onTapFunction: _onItemTapped,
              index: _selectedIndex,
          ),
        )
    );
  }
}
