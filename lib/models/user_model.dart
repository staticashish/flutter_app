import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  String displayName;
  String email;
  String uid;
  String key;

  UserModel({this.displayName, this.email, this.uid });

  UserModel.fromSnapshot(QueryDocumentSnapshot snapshot) :
        key = snapshot.id,
        displayName = snapshot.data()["displayName"],
        email = snapshot.data()["email"],
        uid = snapshot.data()["uid"];

  toJson() {
    return {
      "displayName" : displayName ,
      "email" : email,
      "uid": uid
    };
  }
}