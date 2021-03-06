import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
import 'package:flutter_app/screens/room/room_details_data.dart';

class RoomDetails extends StatefulWidget {
  final RoomModel room;

  RoomDetails({this.room});

  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Room Details",
      ),
      body: RoomDetailsData(
        room: widget.room,
      ),
    );
  }
}
