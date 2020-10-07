import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class CabinetModel {
  String key;
  String cabinetId;
  String cabinetName;
  String cabinetSize;

  CabinetModel(this.cabinetId, this.cabinetName, this.cabinetSize);

  CabinetModel.fromSnapshot(QueryDocumentSnapshot snapshot) :
        key = snapshot.id,
        cabinetId = snapshot.data()["cabinetId"],
        cabinetName = snapshot.data()["cabinetName"],
        cabinetSize = snapshot.data()["cabinetSize"];

  toJson() {
    return {
      "cabinetId": cabinetId,
      "cabinetName": cabinetName,
      "cabinetSize": cabinetSize,
    };
  }
}