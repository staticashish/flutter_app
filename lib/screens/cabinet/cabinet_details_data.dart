import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet_name_with_image.dart';
import 'package:flutter_app/screens/custom/data_field.dart';

class CabinetDetailsData extends StatelessWidget {
  final CabinetModel cabinet;

  CabinetDetailsData({this.cabinet});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              CabinetNameWithImage(
                cabinet: this.cabinet,
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
                        titleText: "Cabinet Name",
                        valueText: this.cabinet.cabinetName,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      DataField(
                        titleText: "Cabinet Size",
                        valueText: this.cabinet.cabinetSize,
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
                        titleText: "Cabinet Description",
                        valueText: this.cabinet.cabinetDescription,
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
                        titleText: "No. of Drawers",
                        valueText: this.cabinet.drawers != null ? this.cabinet.drawers.length.toString(): "0",
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
