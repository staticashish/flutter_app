import 'package:flutter/material.dart';

class CustomDataListTile extends StatefulWidget {
  final String tileText;
  final String imageUrl;

  CustomDataListTile({this.tileText, this.imageUrl});

  @override
  _CustomDataListTileState createState() => _CustomDataListTileState();
}

class _CustomDataListTileState extends State<CustomDataListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
      child: Card(
        elevation: 3,
        shadowColor: Color(0Xff334a7d),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          height: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                    child: widget.imageUrl != null
                        ? Image.network(
                            widget.imageUrl.toString(),
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, progress) =>
                                progress == null
                                    ? child
                                    : LinearProgressIndicator(),
                          )
                        : Image.asset(
                            "assets/images/img_no-image_default.png",
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              VerticalDivider(
                color: Color(0Xff5f6479),
                thickness: 2,
                endIndent: 15,
                indent: 15,
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    widget.tileText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Color(0Xff334a7d),
                    ),
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
    );
  }
}
