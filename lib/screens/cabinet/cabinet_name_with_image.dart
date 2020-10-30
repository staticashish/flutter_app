import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet.dart';

class CabinetNameWithImage extends StatelessWidget {
  final CabinetModel cabinet;

  CabinetNameWithImage({this.cabinet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(50),
            ),
            width: 250,
            height: 250,
            child: this.cabinet.cabinetImageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      this.cabinet.cabinetImageUrl.toString(),
                      fit: BoxFit.fitWidth,
                      height: 250,
                      width: 250,
                      loadingBuilder: (context, child, progress) =>
                          progress == null ? child : LinearProgressIndicator(),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)),
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      "assets/images/img_no-image_default.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
