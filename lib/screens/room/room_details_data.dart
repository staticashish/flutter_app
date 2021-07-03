import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/custom/data_field.dart';
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
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
                    thickness: 2,
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
                    thickness: 2,
                    height: 30,
                  ),
                  Row(
                    children: [
                      DataField(
                        titleText: "No. Of Cabinets",
                        valueText: this.room.cabinets == null
                            ? "0"
                            : this.room.cabinets.length.toString(),
                      ),
                    ],
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
