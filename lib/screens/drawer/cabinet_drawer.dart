import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_drawer_model.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
import 'package:flutter_app/screens/drawer/cabinet_drawer_form.dart';
import 'package:flutter_app/screens/drawer/cabinet_drawer_list.dart';
import 'package:flutter_app/screens/navigation/left_navigation.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/services/storage_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CabinetDrawer extends StatefulWidget {
  @override
  _CabinetDrawerState createState() => _CabinetDrawerState();
}

class _CabinetDrawerState extends State<CabinetDrawer> {

  String drawerKey;

  void _showDrawerAdd(uid) {
    print("context 1: " + context.toString());
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      print("context 2: " + context.toString());
      return StreamProvider<List<CabinetModel>>.value(
          initialData: [],
          child: CabinetDrawerForm(onCreate: _onCreate),
          value: DatabaseService(uid: uid).cabinets);
    }));
  }

  void _showToast(String messageText) {
    Fluttertoast.showToast(
        msg: messageText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0Xff00B8A2),
        textColor: Colors.white,
        fontSize: 15.0);
  }

  _onCreate(
      String drawerName,
      String drawerId,
      String drawerSize,
      String drawerDescription,
      String drawerImageName,
      PickedFile file,
      String uid,
      String cabinetDocId) async {
    String drawerImageUrl =
        await StorageService(uid: uid).uploadImage(File(file.path));
    CabinetDrawerModel drawerModel = new CabinetDrawerModel(
        drawerId,
        drawerName,
        drawerSize,
        drawerDescription,
        drawerImageUrl,
        drawerImageName,
        cabinetDocId);

    await DatabaseService(docId: cabinetDocId, uid: uid)
        .addDrawerData(drawerModel)
        .then((value) {
      setState(() {
        this.drawerKey = value;
      });
    });
    Map<String, dynamic> data = Map();
    data.putIfAbsent("drawers", () => FieldValue.arrayUnion([drawerKey]));
    await DatabaseService(docId: cabinetDocId, uid: uid).updateCabinetData(data);
    _showToast("Drawer Added");
  }

  _onDelete(String drawerImageName, String drawerKey, String uid, String cabinetDocId) async {
    await StorageService(uid: uid).deleteImage(drawerImageName);
    await DatabaseService(uid: uid, docId: drawerKey).deleteDrawerData();
    Map<String, dynamic> data = Map();
    data.putIfAbsent("drawers", () => FieldValue.arrayRemove([drawerKey]));
    await DatabaseService(docId: cabinetDocId, uid: uid).updateCabinetData(data);
    _showToast("Cabinet Removed");
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Drawer",
      ),
      body: SafeArea(
        child: Stack(
          children: [
            CabinetDrawerList(
              onDelete: _onDelete,
            ),
          ],
        ),
      ),
      drawer: LeftNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDrawerAdd(user.uid);
        },
        child: Icon(Icons.add_box),
        backgroundColor: Color(0XffAEEF85),
      ),
    );
  }
}
