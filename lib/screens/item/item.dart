import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_drawer_model.dart';
import 'package:flutter_app/models/item_model.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
import 'package:flutter_app/screens/item/item_form.dart';
import 'package:flutter_app/screens/item/item_list.dart';
import 'package:flutter_app/screens/navigation/left_navigation.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/services/storage_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Item extends StatefulWidget {
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  String itemKey;

  void _showToast(String messageText) {
    Fluttertoast.showToast(
        msg: messageText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0Xff00B8A2),
        textColor: Colors.white,
        fontSize: 15.0);
  }

  void _showItemAdd(uid) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return StreamProvider<List<CabinetDrawerModel>>.value(
          initialData: [],
          child: ItemForm(onCreate: _onCreate),
          value: DatabaseService(uid: uid).drawers);
    }));
  }

  _onCreate(
      String itemName,
      String itemId,
      String itemDescription,
      String itemImageName,
      PickedFile file,
      String uid,
      String drawerDocId) async {
    String cabinetImageUrl =
        await StorageService(uid: uid).uploadImage(File(file.path));
    ItemModel itemModel = new ItemModel(itemId, itemName, itemDescription,
        cabinetImageUrl, itemImageName, drawerDocId);
    await DatabaseService(docId: drawerDocId, uid: uid)
        .addItemData(itemModel)
        .then((value) {
      setState(() {
        this.itemKey = value;
      });
    });
    Map<String, dynamic> data = Map();
    data.putIfAbsent("items", () => FieldValue.arrayUnion([itemKey]));
    await DatabaseService(docId: drawerDocId, uid: uid).updateDrawerData(data);
    _showToast("Item Added");
  }

  _onDelete(String itemImageName, String itemDocId, String uid, String drawerDocId) async {
    await StorageService(uid: uid).deleteImage(itemImageName);
    await DatabaseService(uid: uid, docId: itemDocId).deleteItemData();

    Map<String, dynamic> data = Map();
    data.putIfAbsent("items", () => FieldValue.arrayRemove([itemDocId]));
    await DatabaseService(docId: drawerDocId, uid: uid).updateDrawerData(data);
    _showToast("Item Removed");
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Item",
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ItemList(
              onDelete: _onDelete,
            ),
          ],
        ),
      ),
      drawer: LeftNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showItemAdd(user.uid);
        },
        child: Icon(Icons.add_box),
        backgroundColor: Color(0XffAEEF85),
      ),
    );
  }
}
