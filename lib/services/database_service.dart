import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/cabinet_drawer_model.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/models/item_model.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/item/item.dart';

class DatabaseService {
  final String docId;
  final String uid;

  DatabaseService({this.docId, this.uid});

  final _db = FirebaseFirestore.instance;

  CollectionReference _getUserCollectionReference() {
    FieldValue.serverTimestamp();
    return _db.collection('user');
  }

  CollectionReference _getRoomCollectionReference() {
    return _db.collection('user').doc(uid).collection('room');
  }

  CollectionReference _getCabinetCollectionReference() {
    return _db.collection('user').doc(uid).collection('cabinet');
  }

  CollectionReference _getDrawerCollectionReference() {
    return _db.collection('user').doc(uid).collection('drawer');
  }

  CollectionReference _getItemCollectionReference() {
    return _db.collection('user').doc(uid).collection('item');
  }

  Future addRoomData(RoomModel roomModel) async {
    _getRoomCollectionReference().add(roomModel.toJson()).then((value) {
      return value.id;
    });
  }

  Future<String> addCabinetData(CabinetModel cabinetModel) async {
    return _getCabinetCollectionReference()
        .add(cabinetModel.toJson())
        .then((value) {
      return value.id;
    });
  }

  Future<String> addDrawerData(CabinetDrawerModel cabinetDrawerModel) async {
    return _getDrawerCollectionReference()
        .add(cabinetDrawerModel.toJson())
        .then((value) {
      return value.id;
    });
  }

  Future<String> addItemData(ItemModel itemModel) async {
    return _getItemCollectionReference()
        .add(itemModel.toJson())
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

  Future updateRoomData(Map<String, dynamic> data) async {
    _getRoomCollectionReference().doc(this.docId).update(data);
  }

  Future updateCabinetData(Map<String, dynamic> data) async {
    _getCabinetCollectionReference().doc(this.docId).update(data);
  }

  Future updateDrawerData(Map<String, dynamic> data) async {
    _getDrawerCollectionReference().doc(this.docId).update(data);
  }

  Future deleteRoomData() async {
    _getRoomCollectionReference().doc(this.docId).delete();
  }

  Future deleteCabinetData() async {
    _getCabinetCollectionReference().doc(this.docId).delete();
  }

  Future deleteDrawerData() async {
    _getDrawerCollectionReference().doc(this.docId).delete();
  }

  Future deleteItemData() async {
    _getItemCollectionReference().doc(this.docId).delete();
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

  List<CabinetDrawerModel> _drawerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CabinetDrawerModel.fromSnapshot(doc);
    }).toList();
  }

  List<ItemModel> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ItemModel.fromSnapshot(doc);
    }).toList();
  }

  Stream<List<RoomModel>> get rooms {
    return _getRoomCollectionReference()
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_roomListFromSnapshot);
  }

  Stream<List<CabinetModel>> get cabinets {
    return _getCabinetCollectionReference()
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_cabinetListFromSnapshot);
  }

  Stream<List<CabinetDrawerModel>> get drawers {
    return _getDrawerCollectionReference()
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_drawerListFromSnapshot);
  }

  Stream<List<ItemModel>> get items {
    return _getItemCollectionReference()
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_itemListFromSnapshot);
  }
}