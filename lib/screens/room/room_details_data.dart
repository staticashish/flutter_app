import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/custom/data_field.dart';
import 'package:flutter_app/screens/custom/title_data_field.dart';
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
          Stack(
            children: <Widget>[
              RoomNameWithImage(room: this.room),
            ],
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      TitleDataField(
                        titleText: this.room.roomName,
                        descriptionText: this.room.roomDescription,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DataField(
                          titleText: "Room Size",
                          valueText: this.room.roomSize,
                        ),
                      DataField(
                        titleText: "No. Of Cabinets",
                        valueText: this.room.cabinets == null
                            ? "0"
                            : this.room.cabinets.length.toString(),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    height: 30,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
