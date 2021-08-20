import 'package:cloud_firestore/cloud_firestore.dart';

class CabinetDrawerModel {

  String key;
  String drawerId;
  String drawerName;
  String drawerSize;
  String drawerImageUrl;
  String drawerImageName;
  String drawerDescription;
  String parentDocId;
  List items;

  CabinetDrawerModel(this.drawerId,
      this.drawerName,
      this.drawerSize,
      this.drawerDescription,
      this.drawerImageUrl,
      this.drawerImageName,
      this.parentDocId);

  CabinetDrawerModel.fromSnapshot(QueryDocumentSnapshot snapshot)
      : key = snapshot.id,
        drawerId = snapshot.data()["drawerId"],
        drawerName = snapshot.data()["drawerName"],
        drawerSize = snapshot.data()["drawerSize"],
        drawerDescription = snapshot.data()['drawerDescription'],
        drawerImageUrl = snapshot.data()['drawerImageUrl'],
        drawerImageName = snapshot.data()['drawerImageName'],
        parentDocId = snapshot.data()['parentDocId'],
        items = snapshot.data()['items'];

  toJson() {
    return {
      "drawerId": drawerId,
      "drawerName": drawerName,
      "drawerSize": drawerSize,
      "drawerDescription": drawerDescription,
      "drawerImageUrl": drawerImageUrl,
      "drawerImageName": drawerImageName,
      "parentDocId": parentDocId
    };
  }
}