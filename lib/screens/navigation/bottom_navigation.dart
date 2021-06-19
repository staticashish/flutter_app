import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/screens/custom/app_icons.dart';

class BottomNavigation extends StatefulWidget {
  final int index;
  final Function onTapFunction;

  BottomNavigation({this.index, this.onTapFunction});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  @override
  Widget build(BuildContext context) {

   return BottomNavigationBar(
        currentIndex: widget.index,
        elevation: 10,
        selectedItemColor: Color(0Xff48C392),
       selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
       onTap: widget.onTapFunction,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,

        items: <BottomNavigationBarItem>[
          buildBottomNavigationBarItem(Icons.home, "Home"),
          buildBottomNavigationBarItem(AppIcons.living_room,"Room"),
          buildBottomNavigationBarItem(AppIcons.cabinet,"Cabinet"),
          buildBottomNavigationBarItem(AppIcons.cabinet_drawer,"Drawer"),
          buildBottomNavigationBarItem(AppIcons.tools_things,"Item"),
        ]
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(IconData iconData, String text) {
    return BottomNavigationBarItem(
              icon: Icon(iconData),
              label: text,
    );
  }
}
