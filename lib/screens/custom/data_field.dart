import 'package:flutter/material.dart';

class DataField extends StatelessWidget {
  final String titleText;
  final String valueText;

  const DataField({Key key, this.titleText, this.valueText}) : super(key: key);

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
                  color: Colors.grey[600],
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                this.valueText,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
