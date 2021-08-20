import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String key;
  String itemId;
  String itemName;
  String itemImageUrl;
  String itemImageName;
  String itemDescription;
  String parentDocId;

  ItemModel(this.itemId, this.itemName, this.itemDescription, this.itemImageUrl,
      this.itemImageName, this.parentDocId);

  ItemModel.fromSnapshot(QueryDocumentSnapshot snapshot)
      : key = snapshot.id,
        itemId = snapshot.data()["itemId"],
        itemName = snapshot.data()["itemName"],
        itemImageUrl = snapshot.data()["itemImageUrl"],
        itemImageName = snapshot.data()["itemImageName"],
        itemDescription = snapshot.data()["itemDescription"],
        parentDocId = snapshot.data()["parentDocId"];

  toJson() {
    return {
      "itemId": itemId,
      "itemName": itemName,
      "itemImageUrl": itemImageUrl,
      "itemImageName": itemImageName,
      "itemDescription": itemDescription,
      "parentDocId": parentDocId
    };
  }
}
