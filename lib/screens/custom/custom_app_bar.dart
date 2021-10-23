import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final SearchDelegate searchDelegate;

  CustomAppBar({this.title, this.searchDelegate});

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
        color: Color(0Xff8685EF),
      ),
      bottom: PreferredSize(
        child: Container(
          color: Colors.black12,
          height: 0.5,
        ),
        preferredSize: Size.fromHeight(4.0),
      ),
      title: Text(
        widget.title,
        style: GoogleFonts.montserrat(
          color: Color(0Xff8685EF),
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search_outlined),
          onPressed: () {
            showSearch(context: context, delegate: widget.searchDelegate);
          },
        ),
      ],
    );
  }
}
