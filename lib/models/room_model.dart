import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  String key;
  String roomId;
  String roomName;
  String roomSize;
  String roomImageUrl;
  String roomImageName;
  String roomDescription;
  List cabinets;

  RoomModel(this.roomId, this.roomName, this.roomSize, this.roomDescription,
      this.roomImageUrl, this.roomImageName);

  RoomModel.fromSnapshot(QueryDocumentSnapshot snapshot)
      : key = snapshot.id,
        roomId = snapshot.data()["roomId"],
        roomName = snapshot.data()["roomName"],
        roomSize = snapshot.data()["roomSize"],
        roomImageUrl = snapshot.data()["roomImageUrl"],
        roomImageName = snapshot.data()["roomImageName"],
        roomDescription = snapshot.data()["roomDescription"],
        cabinets = snapshot.data()["cabinets"];


  toJson() {
    return {
      "roomId": roomId,
      "roomName": roomName,
      "roomSize": roomSize,
      "roomImageUrl": roomImageUrl,
      "roomImageName": roomImageName,
      "roomDescription": roomDescription
    };
  }
}
