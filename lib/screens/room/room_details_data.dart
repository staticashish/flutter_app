import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/room/room_name_with_image.dart';

class RoomDetailsData extends StatelessWidget {

  final RoomModel room;
  RoomDetailsData({this.room});


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.4),
                  width: 500,
                  height: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("hi"),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0Xff808cba),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                RoomNameWithImage(room: this.room,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

