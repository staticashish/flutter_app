import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';

class RoomNameWithImage extends StatelessWidget {
  final RoomModel room;

  RoomNameWithImage({this.room});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: this.room.roomImageUrl != null
              ? NetworkImage(
                  this.room.roomImageUrl.toString(),
                )
              : Image.asset(
                  "assets/images/img_no-image_default.png",
                ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
