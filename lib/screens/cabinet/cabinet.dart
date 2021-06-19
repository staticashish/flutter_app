import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet_form.dart';
import 'package:flutter_app/screens/cabinet/cabinet_list.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
import 'package:flutter_app/screens/navigation/left_navigation.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/services/storage_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Cabinet extends StatefulWidget {
  @override
  _CabinetState createState() => _CabinetState();
}

class _CabinetState extends State<Cabinet> {
  bool isLoading = false;
  String cabinetKey;

  void _showToast(String messageText) {
    Fluttertoast.showToast(
        msg: messageText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0Xff586181),
        textColor: Colors.white,
        fontSize: 15.0);
  }

  void _showCabinetAdd(uid) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return StreamProvider<List<RoomModel>>.value(
          initialData: [],
          child: CabinetForm(onCreate: _onCreate),
          value: DatabaseService(uid: uid).rooms);
    }));
  }

  _onCreate(
      String cabinetName,
      String cabinetId,
      String cabinetSize,
      String cabinetDescription,
      String cabinetImageName,
      PickedFile file,
      String uid,
      String roomDocId) async {
    String cabinetImageUrl =
        await StorageService(uid: uid).uploadImage(File(file.path));
    CabinetModel cabinetModel = new CabinetModel(
        cabinetId,
        cabinetName,
        cabinetSize,
        cabinetDescription,
        cabinetImageUrl,
        cabinetImageName,
        roomDocId);
    await DatabaseService(docId: roomDocId, uid: uid)
        .addCabinetData(cabinetModel)
        .then((value) {
      setState(() {
        this.cabinetKey = value;
      });
    });
    Map<String, dynamic> data = Map();
    data.putIfAbsent("cabinets", () => FieldValue.arrayUnion([cabinetKey]));
    await DatabaseService(docId: roomDocId, uid: uid).updateRoomData(data);
    _showToast("Cabinet Added");
  }

  _onDelete(String cabinetImageName, String cabinetKey, String uid) async {
    await StorageService(uid: uid).deleteImage(cabinetImageName);
    await DatabaseService(uid: uid, docId: cabinetKey).deleteCabinetData();
    /* TODO
    Map<String, dynamic> data = Map();
    data.putIfAbsent("cabinets", () => FieldValue.arrayRemove([cabinetKey]));
    await DatabaseService(docId: cabinetKey, uid: uid).updateRoomData(data);*/
    _showToast("Cabinet Removed");
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cabinet",
      ),
      body: SafeArea(
        child: Stack(
          children: [
            CabinetList(
              onDelete: _onDelete,
            ),
          ],
        ),
      ),
      drawer: LeftNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCabinetAdd(user.uid);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
