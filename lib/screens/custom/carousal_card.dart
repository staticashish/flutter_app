import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/item_model.dart';
import 'package:flutter_app/screens/item/item_details.dart';

class CarousalCard extends StatelessWidget {
  final ItemModel item;

  const CarousalCard({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shadowColor: Color(0Xff8685EF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                //Color(0Xffffffff),
                // Color(0Xffffffff),
                // Color(0Xffffffff),
                //Color(0XffEDEDFC),
                Color(0XffB9F196),
                Color(0XffAEEF85),
                //Color(0XffB9B9F5),
                //Color(0XffA8A7F3),
                //Color(0Xff9796F1),
                //Color(0Xff8685EF),
                //Color(0Xff8685EF),
                //Color(0Xff8685EF),
                //Color(0Xff8685EF),
              ]),
        ),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetails(
                      item: this.item,
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                height: MediaQuery.of(context).size.height * 0.24,
                width: MediaQuery.of(context).size.width * 0.73,
                child: CachedNetworkImage(
                  imageUrl: this.item.itemImageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => LinearProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/img_no-image_default.png",
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15.0, 3.0, 10.0, 3.0),
              child: Text(
                this.item.itemName,
                style: TextStyle(
                  // color: Color(0XffEDEDFC),//Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
