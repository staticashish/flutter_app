import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';

class CabinetNameWithImage extends StatelessWidget {
  final CabinetModel cabinet;

  CabinetNameWithImage({this.cabinet});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: this.cabinet.cabinetImageUrl != null
              ? NetworkImage(
                  this.cabinet.cabinetImageUrl.toString(),
                )
              : Image.asset(
                  "assets/images/img_no-image_default.png",
                ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
