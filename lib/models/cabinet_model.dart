import 'package:cloud_firestore/cloud_firestore.dart';

class CabinetModel {
  String key;
  String cabinetId;
  String cabinetName;
  String cabinetSize;
  String cabinetImageUrl;
  String cabinetImageName;
  String cabinetDescription;
  String roomDocId;
  List drawers;

  CabinetModel(
      this.cabinetId,
      this.cabinetName,
      this.cabinetSize,
      this.cabinetDescription,
      this.cabinetImageUrl,
      this.cabinetImageName,
      this.roomDocId);

  CabinetModel.fromSnapshot(QueryDocumentSnapshot snapshot)
      : key = snapshot.id,
        cabinetId = snapshot.data()["cabinetId"],
        cabinetName = snapshot.data()["cabinetName"],
        cabinetSize = snapshot.data()["cabinetSize"],
        cabinetDescription = snapshot.data()['cabinetDescription'],
        cabinetImageUrl = snapshot.data()['cabinetImageUrl'],
        cabinetImageName = snapshot.data()['cabinetImageName'],
        roomDocId = snapshot.data()['roomDocId'],
        drawers = snapshot.data()['drawers'];

  toJson() {
    return {
      "cabinetId": cabinetId,
      "cabinetName": cabinetName,
      "cabinetSize": cabinetSize,
      "cabinetDescription": cabinetDescription,
      "cabinetImageUrl": cabinetImageUrl,
      "cabinetImageName": cabinetImageName,
      roomDocId: true
    };
  }
}
