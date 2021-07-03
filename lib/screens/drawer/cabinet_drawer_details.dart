import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_drawer_model.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
import 'package:flutter_app/screens/drawer/cabinet_drawer_details_data.dart';

class CabinetDrawerDetails extends StatefulWidget {
  final CabinetDrawerModel drawer;

  const CabinetDrawerDetails({Key key, this.drawer}) : super(key: key);

  @override
  _CabinetDrawerDetailsState createState() => _CabinetDrawerDetailsState();
}

class _CabinetDrawerDetailsState extends State<CabinetDrawerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Drawer Details",
      ),
      //backgroundColor: Color(0Xff808cba),
      body: CabinetDrawerDetailsData(
        drawer: widget.drawer,
      ),
    );
  }
}
