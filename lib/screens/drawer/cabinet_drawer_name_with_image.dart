import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_drawer_model.dart';

class CabinetDrawerNameWithImage extends StatelessWidget {

  final CabinetDrawerModel drawer;

  const CabinetDrawerNameWithImage({Key key, this.drawer}) : super(key: key);

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
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30.0),),
          child: CachedNetworkImage(
            imageUrl: this.drawer.drawerImageUrl.toString(),
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
    );
  }
}
