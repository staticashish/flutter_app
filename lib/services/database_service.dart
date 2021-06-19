import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future addRoomData(RoomModel roomModel) async {
    _getRoomCollectionReference().add(roomModel.toJson()).then((value) {
      return value.id;
    });
  }

  Future updateRoomData(Map<String, dynamic> data) async {
    _getRoomCollectionReference().doc(this.docId).update(data);
  }

  Future deleteRoomData() async {
    _getRoomCollectionReference().doc(this.docId).delete();
  }

  Future deleteCabinetData() async {
    _getCabinetCollectionReference().doc(this.docId).delete();
  }

  Future<String> addCabinetData(CabinetModel cabinetModel) async {
    return _getCabinetCollectionReference()
        .add(cabinetModel.toJson())
        .then((value) {
      return value.id;
    });
  }

  Future updateUserData(String displayName, String email) async {
    _getUserCollectionReference().doc(this.uid).set({
      'displayName': displayName,
      'email': email,
    });
  }

  List<RoomModel> _roomListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return RoomModel.fromSnapshot(doc);
    }).toList();
  }

  List<CabinetModel> _cabinetListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CabinetModel.fromSnapshot(doc);
    }).toList();
  }

  Stream<List<RoomModel>> get rooms {
    return _getRoomCollectionReference().snapshots().map(_roomListFromSnapshot);
  }

  Stream<List<CabinetModel>> get cabinets {
    return _getCabinetCollectionReference()
        .snapshots()
        .map(_cabinetListFromSnapshot);
  }
}
