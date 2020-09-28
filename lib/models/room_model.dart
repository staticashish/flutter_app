import 'package:firebase_database/firebase_database.dart';

class RoomModel {
  String key;
  String roomId;
  String roomName;
  String roomSize;

  RoomModel(this.roomId, this.roomName, this.roomSize);

  RoomModel.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        roomId = snapshot.value["roomId"],
        roomName = snapshot.value["roomName"],
        roomSize = snapshot.value["roomSize"];

  toJson() {
    return {
      "roomId": roomId,
      "roomName": roomName,
      "roomSize": roomSize,
    };
  }
}