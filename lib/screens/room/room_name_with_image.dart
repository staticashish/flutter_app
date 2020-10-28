import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';

class RoomNameWithImage extends StatelessWidget {
  final RoomModel room;
  RoomNameWithImage({this.room});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /*Text(
            "Room Name",
            style: TextStyle(
              color: Color(0Xff274986),
              fontSize: 15,
            ),
          ),
          Text(
            this.room.roomName,
            style: TextStyle(
              color: Color(0Xff274986),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),*/
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: this.room.roomImageUrl !=null ? Image.network(
                      this.room.roomImageUrl.toString(),
                      fit: BoxFit.fitWidth,
                      height: 250,
                      width: 250,
                      loadingBuilder: (context, child, progress) =>
                      progress == null
                          ? child
                          : LinearProgressIndicator(),
                    ): Image.asset(
                      "assets/images/img_no-image_default.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}