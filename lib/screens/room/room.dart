import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:provider/provider.dart';

class Room extends StatefulWidget {
  final ValueChanged<int> onTabSelected;

  Room({this.onTabSelected});

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
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

  Future<String> _uploadRoomImage(File file, String uid) async {
    return await StorageService(uid: uid).uploadRoomImage(file);
  }

  _onCreate(String roomName, String roomId, String roomSize, String roomDescription,
      String roomImageName, PickedFile file, String uid) async {
    String roomImageUrl =
        await StorageService(uid: uid).uploadRoomImage(File(file.path));
    RoomModel roomModel =
        new RoomModel(roomId, roomName, roomSize, roomDescription, roomImageUrl, roomImageName);
    await DatabaseService(uid: uid).addRoomData(roomModel);
    _showToast("Room Added");
  }

  _onDelete(String roomImageName, String roomDocId, String uid) async {
    await StorageService(uid: uid).deleteRoomImage(roomImageName);
    await DatabaseService(uid: uid, docId: roomDocId).deleteRoomData();
    _showToast("Room Deleted");
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      drawer: LeftNavigation(),
      appBar: CustomAppBar(
        title: "Room",
      ),
      body: isLoading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : Container(
              child: RoomList(
                onDelete: _onDelete,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRoomAdd();
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0Xff5f72a9),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
