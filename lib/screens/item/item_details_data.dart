import 'package:flutter/material.dart';
import 'package:flutter_app/models/item_model.dart';
import 'package:flutter_app/screens/custom/data_field.dart';
import 'package:flutter_app/screens/custom/title_data_field.dart';
import 'package:flutter_app/screens/item/item_name_with_image.dart';

class ItemDetailsData extends StatelessWidget {
  final ItemModel item;

  ItemDetailsData({this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ItemNameWithImage(
                item: this.item,
              ),
            ],
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleDataField(
                        titleText: this.item.itemName,
                        descriptionText: this.item.itemDescription,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
