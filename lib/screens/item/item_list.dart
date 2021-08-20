import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item_model.dart';
import 'package:flutter_app/screens/custom/custom_data_list_tile.dart';
import 'package:flutter_app/screens/item/item_details.dart';
import 'package:provider/provider.dart';

class ItemList extends StatefulWidget {
  final Function onDelete;

  const ItemList({Key key, this.onDelete}) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
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
    final _items = Provider.of<List<ItemModel>>(context);
    final _user = Provider.of<User>(context);
    if (_items != null && _items.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int index) {
            ItemModel currentItem = _items[index];

            return Dismissible(
              key: Key(currentItem.itemId),
              confirmDismiss: (direction) =>
                  promptUser(direction, currentItem, _user),
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
                  _items.removeAt(index);
                });
              },
              child: InkWell(
                splashColor: Color(0Xff334a7d),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetails(
                        item: currentItem,
                      ),
                    ),
                  );
                },
                child: CustomDataListTile(
                  nameTitle: "Name",
                  nameValue: currentItem.itemName,
                  noOfChildTitle: "",
                  noOfChildvalue: "",
                  imageUrl: currentItem.itemImageUrl,
                ),
              ),
            );
          });
    } else {
      return Center(
          child: Text(
        "Add your first item.",
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
      ));
    }
  }

  Future<bool> promptUser(
      DismissDirection direction, ItemModel item, User user) async {
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
                  await widget.onDelete(item.itemImageName, item.key, user.uid, item.parentDocId);
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
