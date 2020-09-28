import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Search',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),),
    );
  }
}
