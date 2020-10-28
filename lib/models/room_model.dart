import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  String key;
  String roomId;
  String roomName;
  String roomSize;
  String roomImageUrl;
  String roomImageName;

  RoomModel(this.roomId, this.roomName, this.roomSize, this.roomImageUrl, this.roomImageName);

  RoomModel.fromSnapshot(QueryDocumentSnapshot snapshot) :
        key = snapshot.id,
        roomId = snapshot.data()["roomId"],
        roomName = snapshot.data()["roomName"],
        roomSize = snapshot.data()["roomSize"],
        roomImageUrl = snapshot.data()["roomImageUrl"],
        roomImageName = snapshot.data()["roomImageName"];


  toJson() {
    return {
      "roomId": roomId,
      "roomName": roomName,
      "roomSize": roomSize,
      "roomImageUrl": roomImageUrl,
      "roomImageName": roomImageName
    };
  }
}