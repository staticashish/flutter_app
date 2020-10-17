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
import 'package:provider/provider.dart';

class Room extends StatefulWidget {
  ValueChanged<int> onTabSelected;

  Room({this.onTabSelected});

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  bool isLoading = false;

  void _showRoomAdd() {
    setState(() {
      isLoading = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RoomForm(
                onCreate: _onCreate,
                onUploadRoomImage: _uploadRoomImage,
              )),
    );
  }

  Future<String> _uploadRoomImage(File file, String uid) async {
    return await StorageService(uid: uid).uploadRoomImage(file);
  }

  _onCreate(String roomName, String roomId, String roomSize, String roomImageUrl, String uid) async {
    RoomModel roomModel = new RoomModel(roomId, roomName, roomSize, roomImageUrl);
    await DatabaseService(uid: uid).addRoomData(roomName, roomId, roomSize, roomImageUrl);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      drawer: LeftNavigation(),
      appBar: CustomAppBar(
        title: "Room",
      ),
      body: Container(
        child: RoomList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          _showRoomAdd();
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0Xff5f72a9),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
