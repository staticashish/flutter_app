import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';

class RoomNameWithImage extends StatelessWidget {
  final RoomModel room;
  RoomNameWithImage({this.room});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.width / 1.5,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 2.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        child: Image(
          image: this.room.roomImageUrl != null
              ? NetworkImage(
                  this.room.roomImageUrl.toString(),
                )
              : Image.asset(
                  "assets/images/img_no-image_default.png",
                ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
