import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet_details_data.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';

class CabinetDetails extends StatefulWidget {
  final CabinetModel cabinet;

  CabinetDetails({this.cabinet});

  @override
  _CabinetDetailsState createState() => _CabinetDetailsState();
}

class _CabinetDetailsState extends State<CabinetDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cabinet Details",
      ),
      //backgroundColor: Color(0Xff808cba),
      body: CabinetDetailsData(
        cabinet: widget.cabinet,
      ),
    );
  }
}
