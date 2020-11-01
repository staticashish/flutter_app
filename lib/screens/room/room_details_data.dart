import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/custom/data_field.dart';
import 'package:flutter_app/screens/room/room_name_with_image.dart';
import 'package:google_fonts/google_fonts.dart';

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
                RoomNameWithImage(
                  room: this.room,
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  width: 500,
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DataField(
                            titleText: "Room Name",
                            valueText: this.room.roomName,
                          ),
                          DataField(
                            titleText: "Room Size",
                            valueText: this.room.roomSize,
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 5,
                        height: 30,
                      ),
                      Row(
                        children: [
                          DataField(
                            titleText: "Room Description",
                            valueText: this.room.roomDescription,
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 5,
                        height: 30,
                      ),
                      Row(
                        children: [
                          DataField(
                            titleText: "No. Of Cabinets",
                            valueText: this.room.cabinets == null ? "0" : this.room.cabinets.length.toString(),
                          ),
                        ],
                      )
                    ]),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0Xffffffff),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
