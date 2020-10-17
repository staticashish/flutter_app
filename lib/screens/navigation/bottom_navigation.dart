import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/screens/custom/app_icons.dart';

class BottomNavigation extends StatefulWidget {
  int index;
  Function onTapFunction;

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
        selectedItemColor: Color(0Xff5f72a9),
        onTap: widget.onTapFunction,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          buildBottomNavigationBarItem(Icons.home, "Home"),
          buildBottomNavigationBarItem(AppIcons.living_room,"Room"),
          buildBottomNavigationBarItem(AppIcons.cabinet,"Cabinet"),
          buildBottomNavigationBarItem(AppIcons.cabinet_drawer,"Drawer"),
          buildBottomNavigationBarItem(AppIcons.tools_things,"Thing"),
        ]
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(IconData iconData, String text) {
    return BottomNavigationBarItem(
              icon: Icon(iconData),
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                child: Text(text, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                ),
                ),
              )
          );
  }
}
