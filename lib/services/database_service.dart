import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/models/room_model.dart';

class DatabaseService {

  final String docId;
  final String uid;
  DatabaseService({this.docId, this.uid});

  final _db = FirebaseFirestore.instance;

  CollectionReference _getUserCollectionReference() {
    return _db.collection('user');
  }

  CollectionReference _getRoomCollectionReference() {
    return _db.collection('user').doc(uid).collection('room');
  }

  CollectionReference _getCabinetCollectionReference() {
    return _db.collection('user').doc(uid).collection('cabinet');
  }

  Future addRoomData(String roomName, String roomId, String roomSize) async {
    _getRoomCollectionReference().add({
      'roomName' : roomName,
      'roomId' : roomId,
      'roomSize' : roomSize,
    });
  }

  Future addCabinetData(String cabinetName, String cabinetId, String cabinetSize) async {
    _getCabinetCollectionReference().add({
      'cabinetName' : cabinetName,
      'cabinetId' : cabinetId,
      'cabinetSize' : cabinetSize,
      this.docId : true
    });
  }

  Future updateUserData(String displayName, String email) async {
    _getUserCollectionReference().doc(this.uid).set({
      'displayName' : displayName,
      'email' : email,
    });
  }

  Future updateRoomData(String roomName, String roomId, String roomSize) async {
    _getRoomCollectionReference().doc(this.docId).set({
      'roomName' : roomName,
      'roomId' : roomId,
      'roomSize' : roomSize,
    });
  }

  List<RoomModel> _roomListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return RoomModel.fromSnapshot(doc);
    }).toList();
  }

  List<CabinetModel> _cabinetListFromSnapshot(QuerySnapshot snapshot) {
    print(snapshot.docs);
    return snapshot.docs.map((doc) {
      print("cabinet");
      print(doc.data());
      return CabinetModel.fromSnapshot(doc);
    }).toList();
  }

  Stream<List<RoomModel>> get rooms {
    return _getRoomCollectionReference()
        .snapshots()
        .map(_roomListFromSnapshot);
  }

  Stream<List<CabinetModel>> get cabinets {
    return _getCabinetCollectionReference()
        .snapshots()
        .map(_cabinetListFromSnapshot);
  }
}