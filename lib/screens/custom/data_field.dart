import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';

class DataField extends StatelessWidget {

  final String titleText;
  final String valueText;

  const DataField({Key key, this.titleText, this.valueText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.titleText,
            style: TextStyle(
              color: Color(0Xff2b3c63),
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            this.valueText,
            style: TextStyle(
              color: Color(0Xff2b3c63),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
