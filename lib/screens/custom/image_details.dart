import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDetails extends StatelessWidget {
  final imagePath;

  const ImageDetails({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ClipRRect(
          child: CachedNetworkImage(
            imageUrl: this.imagePath,
            fit: BoxFit.cover,
            //width: 100,
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
