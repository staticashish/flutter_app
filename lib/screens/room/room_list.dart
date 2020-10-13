import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet.dart';
import 'package:flutter_app/screens/cabinet/cabinet_list.dart';
import 'package:provider/provider.dart';

class RoomList extends StatefulWidget {
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
    if (_rooms != null && _rooms.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _rooms.length,
          itemBuilder: (BuildContext context, int index) {
            String roomName = _rooms[index].roomName;
            String roomId = _rooms[index].roomId;
            String roomSize = _rooms[index].roomSize;

            return Dismissible(
              key: Key(roomId),
              confirmDismiss: (direction) => promptUser(direction),
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
                print(_rooms[index].roomName);
                setState(() {
                  _rooms.removeAt(index);
                });
              },
              child: Card(
                shadowColor: Color(0Xff5f72a9),
                elevation: 10,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    //bottomRight: Radius.circular(5),
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    //bottomLeft: Radius.circular(5)
                  ),
                ),
                child: ExpansionTile(
                  leading: Image.asset("assets/images/img_home_room.png"),
                  tilePadding: EdgeInsets.fromLTRB(10, 15, 0, 15),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      roomName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0Xff334a7d)),
                    ),
                  ),
                  trailing: _showMenuButton(),
                  children: [
                    ListTile(
                      title: Text(roomId),
                    ),
                    ListTile(
                      title: Text(roomSize),
                    ),
                  ],
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

  Future<bool> promptUser(DismissDirection direction) async {
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
