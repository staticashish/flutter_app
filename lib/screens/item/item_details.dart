import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/models/item_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet_details_data.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
import 'package:flutter_app/screens/item/item_details_data.dart';

class ItemDetails extends StatefulWidget {
  final ItemModel item;

  ItemDetails({this.item});

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Item Details",
      ),
      //backgroundColor: Color(0Xff808cba),
      body: ItemDetailsData(
        item: widget.item,
      ),
    );
  }
}
