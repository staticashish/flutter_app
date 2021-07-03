import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/custom/data_field.dart';

class CustomDataListTile extends StatefulWidget {
  final String imageUrl;
  final String nameTitle;
  final String nameValue;
  final String noOfChildTitle;
  final String noOfChildvalue;

  CustomDataListTile(
      {this.imageUrl,
      this.nameTitle,
      this.nameValue,
      this.noOfChildTitle,
      this.noOfChildvalue});

  @override
  _CustomDataListTileState createState() => _CustomDataListTileState();
}

class _CustomDataListTileState extends State<CustomDataListTile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.fromLTRB(40.0, 5.0, 5.0, 5.0),
          elevation: 10,
          shadowColor: Color(0Xff334A7D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: 120,
            margin: const EdgeInsets.fromLTRB(85.0, 1.0, 1.0, 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DataField(
                          titleText: widget.nameTitle,
                          valueText: widget.nameValue,
                        ),
                        DataField(
                          titleText: widget.noOfChildTitle,
                          valueText: widget.noOfChildvalue,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_right),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 10.0,
          top: 15.0,
          bottom: 15.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl.toString(),
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
      ],
    );
  }
}
