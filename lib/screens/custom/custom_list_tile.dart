import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  IconData icon;
  String tileText;
  Function action;

  CustomListTile(this.icon, this.tileText, this.action);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
              color: Colors.grey[300]
          )
          )
        ),
        child: InkWell(
          splashColor: Color(0Xff334a7d),
          onTap: widget.action,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    Icon(widget.icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.tileText,
                        style: TextStyle(
                           fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
