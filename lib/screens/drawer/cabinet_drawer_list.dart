import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_drawer_model.dart';
import 'package:flutter_app/screens/custom/custom_data_list_tile.dart';
import 'package:flutter_app/screens/drawer/cabinet_drawer_details.dart';
import 'package:provider/provider.dart';

class CabinetDrawerList extends StatefulWidget {
  final Function onDelete;

  const CabinetDrawerList({Key key, this.onDelete}) : super(key: key);

  @override
  _CabinetDrawerListState createState() => _CabinetDrawerListState();
}

class _CabinetDrawerListState extends State<CabinetDrawerList> {
  @override
  Widget build(BuildContext context) {
    final _drawers = Provider.of<List<CabinetDrawerModel>>(context);
    final _user = Provider.of<User>(context);
    if (_drawers != null && _drawers.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _drawers.length,
          itemBuilder: (BuildContext context, int index) {
            CabinetDrawerModel currentDrawer = _drawers[index];

            return Dismissible(
              key: Key(currentDrawer.drawerId),
              confirmDismiss: (direction) =>
                  promptUser(direction, currentDrawer, _user),
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
                  _drawers.removeAt(index);
                });
              },
              child: InkWell(
                splashColor: Color(0Xff334a7d),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CabinetDrawerDetails(
                        drawer: currentDrawer,
                      ),
                    ),
                  );
                },
                child: CustomDataListTile(
                  nameTitle: "Name",
                  nameValue: currentDrawer.drawerName,
                  noOfChildTitle: "No. of Items",
                  noOfChildvalue: currentDrawer.items != null
                      ? currentDrawer.items.length.toString()
                      : "0",
                  imageUrl: currentDrawer.drawerImageUrl,
                ),
              ),
            );
          });
    } else {
      return Center(
        child: Text(
          "Add your first drawer.",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0Xff48C392),
              shadows: [
                Shadow(
                  color: Colors.blueGrey,
                  blurRadius: 20.0,
                  offset: Offset(5.0, 5.0),
                )
              ]),
        ),
      );
    }
  }

  Future<bool> promptUser(
      DismissDirection direction, CabinetDrawerModel drawer, User user) async {
    String action;
    if (direction == DismissDirection.startToEnd) {
      action = "archive";
    } else {
      action = "delete";
    }

    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 10,
            content: Text("Are you sure you want to $action?"),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  await widget.onDelete(drawer.drawerImageName, drawer.key,
                      user.uid, drawer.parentDocId);
                  Navigator.of(context).pop(true);
                },
              ),
              TextButton(
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
