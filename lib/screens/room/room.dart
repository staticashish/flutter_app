import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/room/room_form.dart';
import 'package:provider/provider.dart';

class Room extends StatefulWidget {

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {

  List<RoomModel> _rooms;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  StreamSubscription<Event> _onRoomAddedSubscription;
  StreamSubscription<Event> _onRoomChangedSubscription;
  Query _roomQuery;

  @override
  void initState() {
    super.initState();
    _rooms = new List();
    _roomQuery = _database.reference().child('room');
    _onRoomAddedSubscription = _roomQuery.onChildAdded.listen(_onEntryAdded);
    _onRoomChangedSubscription = _roomQuery.onChildAdded.listen(_onEntryChanged);
  }

  _onEntryChanged(Event event) {
    var oldEntry = _rooms.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _rooms[_rooms.indexOf(oldEntry)] =
          RoomModel.fromSnapshot(event.snapshot);
    });
  }

  _onEntryAdded(Event event) {
    print('on added');
    setState(() {
      _rooms.add(RoomModel.fromSnapshot(event.snapshot));
    });
  }

  @override
  void dispose() {
    _onRoomAddedSubscription.cancel();
    _onRoomChangedSubscription.cancel();
    super.dispose();
  }

  void _showRoomAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RoomForm(onCreate: _onCreate)),
    );
  }

  _onCreate(String roomName, String roomId, String roomSize) {
    print('On create');
    print(roomName);
    print(roomId);
    print(roomSize);
    RoomModel roomModel = new RoomModel(roomId, roomName, roomSize);
    _database.reference().child("room").push().set(roomModel.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildRoomList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRoomAdd();
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0Xff5f72a9),
      ),
    );
  }

  Widget buildRoomList() {
    if(_rooms.length > 0 ) {

      return ListView.builder(
          shrinkWrap: true,
          itemCount: _rooms.length,
          itemBuilder: (BuildContext context, int index) {
            String roomKey = _rooms[index].key;
            String roomName = _rooms[index].roomName;
            String roomId = _rooms[index].roomId;
            String roomSize = _rooms[index].roomSize;

            return Card(
              elevation: 30,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)
                ),
              ),
              child: ListTile(
                  leading: Icon(Icons.flight_land),
                  title: Text(roomName),
                  subtitle: Text(roomId),
                  trailing: Icon(Icons.more_vert),
                  onTap: () {
                  }
              ),
            );
          });
    } else {
      return Center(
          child: Text(
            "Add your first room.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0Xff5f72a9),
                shadows: [
                  Shadow(
                    color: Colors.blueGrey,
                    blurRadius: 20.0,
                    offset: Offset(5.0, 5.0),
                  )
                ]
            ),
          )
      );
    }

  }
}
