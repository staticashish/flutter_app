import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/room/room_form.dart';
import 'package:flutter_app/screens/room/room_list.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:provider/provider.dart';

class Room extends StatefulWidget {
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
      MaterialPageRoute(builder: (context) => RoomForm(onCreate: _onCreate)),
    );
  }

  _onCreate(String roomName, String roomId, String roomSize, String uid) async {
    RoomModel roomModel = new RoomModel(roomId, roomName, roomSize);
    await DatabaseService(uid: uid).addRoomData(roomName, roomId, roomSize);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    print("==> .."+user.uid);
    return Scaffold(
      body: RoomList(),
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
    );
  }
}
