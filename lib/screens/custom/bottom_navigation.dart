import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

    return Container(
      child: BottomNavigationBar(
          currentIndex: widget.index,
          elevation: 10.0,
          selectedItemColor: Color(0Xff5f72a9),
          onTap: widget.onTapFunction,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            buildBottomNavigationBarItem("assets/images/img_room_icon.png","Room"),
            buildBottomNavigationBarItem("assets/images/img_cabinet_icon_1.png","Cabinet"),
            buildBottomNavigationBarItem("assets/images/img_things_icon.png","Things"),
            buildBottomNavigationBarItem("assets/images/img_search_icon.png","Search"),
          ]
      )
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(String image, String text) {
    return BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(image),
                size: 30,
              ),
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                child: Text(text, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                ),
                ),
              )
          );
  }
}
