import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
import 'package:flutter_app/screens/navigation/left_navigation.dart';
import 'package:flutter_app/screens/room/room_form.dart';
import 'package:flutter_app/screens/room/room_list.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/services/storage_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Room extends StatefulWidget {
  final ValueChanged<int> onTabSelected;

  Room({this.onTabSelected});

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
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

  void _showRoomAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoomForm(
          onCreate: _onCreate,
        ),
      ),
    );
  }

  _onCreate(
      String roomName,
      String roomId,
      String roomSize,
      String roomDescription,
      String roomImageName,
      PickedFile file,
      String uid) async {
    String roomImageUrl =
        await StorageService(uid: uid).uploadImage(File(file.path));
    RoomModel roomModel = new RoomModel(roomId, roomName, roomSize,
        roomDescription, roomImageUrl, roomImageName);
    await DatabaseService(uid: uid).addRoomData(roomModel);
    _showToast("Room Added");
  }

  _onDelete(String roomImageName, String roomDocId, String uid) async {
    await StorageService(uid: uid).deleteImage(roomImageName);
    await DatabaseService(uid: uid, docId: roomDocId).deleteRoomData();
    _showToast("Room Deleted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftNavigation(),
      appBar: CustomAppBar(
        title: "Room",
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: RoomList(
                onDelete: _onDelete,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRoomAdd();
        },
        child: Icon(Icons.add_box_rounded),
        backgroundColor: Color(0XffAEEF85),
      ),
    );
  }
}
