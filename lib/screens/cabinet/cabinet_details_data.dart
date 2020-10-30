import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet_name_with_image.dart';
import 'package:flutter_app/screens/room/room_name_with_image.dart';
import 'package:google_fonts/google_fonts.dart';

class CabinetDetailsData extends StatelessWidget {
  final CabinetModel cabinet;

  CabinetDetailsData({this.cabinet});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.4),
                  width: 500,
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Cabinet Name",
                              style: TextStyle(
                                color: Color(0Xffffffff),
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              this.cabinet.cabinetName,
                              style: TextStyle(
                                color: Color(0Xffffffff),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cabinet Size",
                              style: TextStyle(
                                color: Color(0Xffffffff),
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              this.cabinet.cabinetSize,
                              style: TextStyle(
                                color: Color(0Xffffffff),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0Xff808cba),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                CabinetNameWithImage(
                  cabinet: this.cabinet,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
