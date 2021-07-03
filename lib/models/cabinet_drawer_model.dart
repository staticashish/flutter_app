import 'package:cloud_firestore/cloud_firestore.dart';

class CabinetDrawerModel {

  String key;
  String drawerId;
  String drawerName;
  String drawerSize;
  String drawerImageUrl;
  String drawerImageName;
  String drawerDescription;
  String cabinetDocId;

  CabinetDrawerModel(this.drawerId,
      this.drawerName,
      this.drawerSize,
      this.drawerDescription,
      this.drawerImageUrl,
      this.drawerImageName,
      this.cabinetDocId);

  CabinetDrawerModel.fromSnapshot(QueryDocumentSnapshot snapshot)
      : key = snapshot.id,
        drawerId = snapshot.data()["drawerId"],
        drawerName = snapshot.data()["drawerName"],
        drawerSize = snapshot.data()["drawerSize"],
        drawerDescription = snapshot.data()['drawerDescription'],
        drawerImageUrl = snapshot.data()['drawerImageUrl'],
        drawerImageName = snapshot.data()['drawerImageName'],
        cabinetDocId = snapshot.data()['cabinetDocId'];

  toJson() {
    return {
      "drawerId": drawerId,
      "drawerName": drawerName,
      "drawerSize": drawerSize,
      "drawerDescription": drawerDescription,
      "drawerImageUrl": drawerImageUrl,
      "drawerImageName": drawerImageName,
      cabinetDocId: true
    };
  }
}