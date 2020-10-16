import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class RoomModel {
  String key;
  String roomId;
  String roomName;
  String roomSize;
  String roomImageUrl;

  RoomModel(this.roomId, this.roomName, this.roomSize, this.roomImageUrl);

  RoomModel.fromSnapshot(QueryDocumentSnapshot snapshot) :
        key = snapshot.id,
        roomId = snapshot.data()["roomId"],
        roomName = snapshot.data()["roomName"],
        roomSize = snapshot.data()["roomSize"],
        roomImageUrl = snapshot.data()["roomImageUrl"];

  toJson() {
    return {
      "roomId": roomId,
      "roomName": roomName,
      "roomSize": roomSize,
      "roomImageUrl": roomImageUrl
    };
  }
}