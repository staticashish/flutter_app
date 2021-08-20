import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_drawer_model.dart';
import 'package:flutter_app/screens/custom/data_field.dart';
import 'package:flutter_app/screens/custom/title_data_field.dart';
import 'package:flutter_app/screens/drawer/cabinet_drawer_name_with_image.dart';

class CabinetDrawerDetailsData extends StatelessWidget {
  final CabinetDrawerModel drawer;

  const CabinetDrawerDetailsData({Key key, this.drawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              CabinetDrawerNameWithImage(
                drawer: this.drawer,
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
                        titleText: this.drawer.drawerName,
                        descriptionText: this.drawer.drawerDescription,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DataField(
                        titleText: "Drawer Size",
                        valueText: this.drawer.drawerSize,
                      ),
                      DataField(
                        titleText: "No. of Items",
                        valueText: this.drawer.items != null ? this.drawer.items.length.toString(): "0",
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    height: 30,
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
