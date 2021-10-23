import 'package:flutter/material.dart';

class DashboardDataCard extends StatefulWidget {
  final String title;
  final String data;

  const DashboardDataCard({Key key, this.title, this.data}) : super(key: key);

  @override
  _DashboardDataCardState createState() => _DashboardDataCardState();
}

class _DashboardDataCardState extends State<DashboardDataCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.17,
      width: MediaQuery.of(context).size.height * 0.20,
      decoration: BoxDecoration(
        color: Colors.white,//Color(0XffEDEDFC), //Color(0Xff8685EF),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color(0Xff8685EF).withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(2, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: Center(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: Color(0XffB9B9F5),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 3,
            child: Center(
              child: Text(
                widget.data,
                style: TextStyle(
                  color: Color(0Xff8685EF), //Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
