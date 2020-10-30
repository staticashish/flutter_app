import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet_form.dart';
import 'package:flutter_app/screens/cabinet/cabinet_list.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
import 'file:///C:/Nisha/projects/mobile-app/flutter_app/lib/screens/navigation/left_navigation.dart';
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
    setState(() {
      isLoading = true;
    });

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return StreamProvider<List<RoomModel>>.value(
          child: CabinetForm(onCreate: _onCreate),
          value: DatabaseService(uid: uid).rooms);
    }));
  }

  _onCreate(
      String cabinetName,
      String cabinetId,
      String cabinetSize,
      String cabinetImageName,
      PickedFile file,
      String uid,
      String roomDocId) async {
    String cabinetImageUrl =
        await StorageService(uid: uid).uploadCabinetImage(File(file.path));
    CabinetModel cabinetModel = new CabinetModel(
        cabinetId, cabinetName, cabinetSize, cabinetImageUrl, cabinetImageName, roomDocId);
    await DatabaseService(docId: roomDocId, uid: uid)
        .addCabinetData(cabinetModel);
    setState(() {
      isLoading = false;
    });
    _showToast("Cabinet Added");
  }

  _onDelete(String cabinetImageName, String roomDocId, String uid) async {
    await StorageService(uid: uid).deleteCabinetImage(cabinetImageName);
    await DatabaseService(uid: uid, docId: roomDocId).deleteCabinetData();
    _showToast("Cabinet Removed");
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      body: CabinetList(
        onDelete: _onDelete,
      ),
      drawer: LeftNavigation(),
      appBar: CustomAppBar(
        title: "Cabinet",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCabinetAdd(user.uid);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0Xff5f72a9),
      ),
    );
  }
}
