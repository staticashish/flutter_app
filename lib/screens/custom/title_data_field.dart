import 'package:flutter/material.dart';

class TitleDataField extends StatelessWidget {
  final String titleText;
  final String descriptionText;

  const TitleDataField({Key key, this.titleText, this.descriptionText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.titleText,
                style: TextStyle(
                  color: Color(0Xff8685EF),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                this.descriptionText,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
