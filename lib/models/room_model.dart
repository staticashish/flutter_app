import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class RoomModel {
  String key;
  String roomId;
  String roomName;
  String roomSize;

  RoomModel(this.roomId, this.roomName, this.roomSize);

  RoomModel.fromSnapshot(QueryDocumentSnapshot snapshot) :
        key = snapshot.id,
        roomId = snapshot.data()["roomId"],
        roomName = snapshot.data()["roomName"],
        roomSize = snapshot.data()["roomSize"];

  toJson() {
    return {
      "roomId": roomId,
      "roomName": roomName,
      "roomSize": roomSize,
    };
  }
}