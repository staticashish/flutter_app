import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/screens/custom/image_details.dart';

class CabinetNameWithImage extends StatelessWidget {
  final CabinetModel cabinet;

  CabinetNameWithImage({this.cabinet});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.width / 1.5,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 2.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageDetails(
                  imagePath: this.cabinet.cabinetImageUrl.toString(),
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.0),),
            child: CachedNetworkImage(
              imageUrl: this.cabinet.cabinetImageUrl.toString(),
              fit: BoxFit.cover,
              width: 100,
              placeholder: (context, url) => LinearProgressIndicator(),
              errorWidget: (context, url, error) => Image.asset(
                "assets/images/img_no-image_default.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
