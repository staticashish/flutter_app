import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:provider/provider.dart';

class CabinetList extends StatefulWidget {
  @override
  _CabinetListState createState() => _CabinetListState();
}

class _CabinetListState extends State<CabinetList> {
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
        });
  }

  @override
  Widget build(BuildContext context) {
    final _cabinets = Provider.of<List<CabinetModel>>(context);
    if (_cabinets != null && _cabinets.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _cabinets.length,
          itemBuilder: (BuildContext context, int index) {
            String cabinetName = _cabinets[index].cabinetName;
            String cabinetId = _cabinets[index].cabinetId;

            return Dismissible(
              key: Key(cabinetId),
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
                print(_cabinets[index].cabinetName);
                setState(() {
                  _cabinets.removeAt(index);
                });
              },
              child: Card(
                shadowColor: Color(0Xff5f72a9),
                elevation: 10,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    // bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    // bottomLeft: Radius.circular(10)
                  ),
                ),
                child: ExpansionTile(
                  leading: Image.asset("assets/images/img_home_room.png"),
                  tilePadding: EdgeInsets.fromLTRB(10, 15, 0, 15),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cabinetName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0Xff334a7d)),
                    ),
                  ),
                  trailing: _showMenuButton(),
                  children: [
                    ListTile(
                      title: Text(cabinetId),
                    )
                  ],
                ),
              ),
            );
          });
    } else {
      return Center(
          child: Text(
        "Add your first cabinet.",
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
