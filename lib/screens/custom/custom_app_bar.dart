import 'dart:ui';

import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  CustomAppBar({this.title});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Color(0Xff48C392),
      ),
      bottom: PreferredSize(
        child: Container(
          color: Colors.black26,
          height: 0.0,
        ),
        preferredSize: Size.fromHeight(4.0),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          color: Color(0Xff48C392),
        ),
      ),
    );
  }
}
