import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet_details.dart';
import 'package:flutter_app/screens/custom/custom_data_list_tile.dart';
import 'package:provider/provider.dart';

class CabinetList extends StatefulWidget {

  final Function onDelete;
  const CabinetList({Key key, this.onDelete}) : super(key: key);

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
    final _user = Provider.of<User>(context);
    if (_cabinets != null && _cabinets.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _cabinets.length,
          itemBuilder: (BuildContext context, int index) {
            CabinetModel currentCabinet = _cabinets[index];

            return Dismissible(
              key: Key(currentCabinet.cabinetId),
              confirmDismiss: (direction) => promptUser(direction, currentCabinet, _user),
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
                  _cabinets.removeAt(index);
                });
              },
              child: InkWell(
                splashColor: Color(0Xff334a7d),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CabinetDetails(
                        cabinet: currentCabinet,
                      ),
                    ),
                  );
                },
                child: CustomDataListTile(
                  tileText: currentCabinet.cabinetName,
                  imageUrl: currentCabinet.cabinetImageUrl,
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

  Future<bool> promptUser(DismissDirection direction, CabinetModel cabinet, User user) async {
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
                onPressed: () async {
                  await widget.onDelete(cabinet.cabinetImageName, cabinet.key, user.uid);
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
