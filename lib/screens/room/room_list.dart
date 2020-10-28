import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet.dart';
import 'package:flutter_app/screens/custom/custom_data_list_tile.dart';
import 'package:flutter_app/screens/room/room_details.dart';
import 'package:provider/provider.dart';

class RoomList extends StatefulWidget {

  final Function onDelete;
  RoomList({this.onDelete});

  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  _showMenuButton() {
    return PopupMenuButton(
        itemBuilder: (_) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                  child: const Text('Cabinet'), value: 'cabinet'),
              new PopupMenuItem<String>(
                  child: const Text('Thing'), value: 'thing'),
            ],
        onSelected: (value) {
          print(value.toString());
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Cabinet()),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final _rooms = Provider.of<List<RoomModel>>(context);
    final _user = Provider.of<User>(context);
    if (_rooms != null && _rooms.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _rooms.length,
          itemBuilder: (BuildContext context, int index) {
            RoomModel currentRoom = _rooms[index];

            return Dismissible(
              key: Key(currentRoom.roomId),
              confirmDismiss: (direction) => promptUser(direction, currentRoom, _user),
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Color(0Xffba504b),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  _rooms.removeAt(index);
                });
              },
              child: InkWell(
                splashColor: Color(0Xff334a7d),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomDetails(
                        room: currentRoom,
                      ),
                    ),
                  );
                },
                child: CustomDataListTile(
                  tileText: currentRoom.roomName,
                  imageUrl: currentRoom.roomImageUrl,
                ),
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
            ]),
      ));
    }
  }

  Future<bool> promptUser(DismissDirection direction, RoomModel room, User user) async {
    String action;
    if (direction == DismissDirection.startToEnd) {
      action = "archive";
    } else {
      action = "delete";
    }

    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text("Are you sure you want to $action?"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Ok"),
                onPressed: () {
                  print(room.roomName);
                  print(room.roomName);
                  print(room.roomImageName);
                  widget.onDelete(room.roomImageName, room.key, user.uid);
                  Navigator.of(context).pop(true);
                },
              ),
              CupertinoDialogAction(
                child: Text('Cancel'),
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        ) ??
        false; // In case the user dismisses the dialog by clicking away from it
  }
}
