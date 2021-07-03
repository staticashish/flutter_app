import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_drawer_model.dart';
import 'package:flutter_app/screens/custom/data_field.dart';
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DataField(
                        titleText: "Drawer Name",
                        valueText: this.drawer.drawerName,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      DataField(
                        titleText: "Drawer Size",
                        valueText: this.drawer.drawerSize,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DataField(
                        titleText: "Drawer Description",
                        valueText: this.drawer.drawerDescription,
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
