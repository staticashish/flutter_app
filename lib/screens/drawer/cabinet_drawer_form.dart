import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
import 'package:flutter_app/screens/custom/image_selector.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CabinetDrawerForm extends StatefulWidget {

  final Function onCreate;
  const CabinetDrawerForm({Key key, this.onCreate}) : super(key: key);

  @override
  _CabinetDrawerFormState createState() => _CabinetDrawerFormState();
}

class _CabinetDrawerFormState extends State<CabinetDrawerForm> {

  final _formKey = GlobalKey<FormState>();
  final uuid = Uuid();
  String drawerName;
  String drawerId;
  String drawerSize;
  String drawerDescription;
  String roomName;
  CabinetModel selectedCabinet;
  PickedFile _image;

  _onImageSelect(PickedFile file) {
    this._image = file;
  }

  @override
  Widget build(BuildContext context) {


    final _cabinets = Provider.of<List<CabinetModel>>(context);
    final _user = Provider.of<User>(context);
    if (_cabinets != null && _cabinets.length > 0) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Add Drawer',
        ),
        body: ProgressHUD(
          indicatorWidget: Container(
            child: SpinKitWave(
              color: Colors.green,
            ),
          ),
          child: Builder(
            builder: (context) => SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: ImageSelector(
                              onImageSelect: _onImageSelect,
                            )),
                        const Divider(
                          height: 20.0,
                          indent: 20.0,
                          endIndent: 20.0,
                          thickness: 1.0,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter a cabinet name";
                            }
                            return null;
                          },
                          obscureText: false,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            hintText: 'drawer',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            labelText: "Enter drawer Name",
                            labelStyle: TextStyle(
                              color: Color(0Xff9cacbf),
                            ),
                            fillColor: Colors.white,
                          ),
                          onChanged: (val) {
                            setState(() {
                              drawerName = val;
                            });
                          },
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter an drawer size";
                            }
                            return null;
                          },
                          obscureText: false,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            hintText: '100X200',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            labelText: "Enter drawer Size",
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Color(0Xff9cacbf),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              drawerSize = val;
                            });
                          },
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter an drawer description";
                            }
                            return null;
                          },
                          obscureText: false,
                          maxLines: 2,
                          maxLength: 200,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            hintText: 'drawer description',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            labelText: "Enter Drawer Description",
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Color(0Xff9cacbf),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              drawerDescription = val;
                            });
                          },
                        ),
                        DropdownButtonFormField(
                          value: selectedCabinet != null ? selectedCabinet : null,
                          decoration: InputDecoration(
                            hintText: 'Please Select',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            labelText: "Select Cabinet",
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Color(0Xff9cacbf),
                            ),
                          ),
                          items: _cabinets.map((cabinet) {
                            return DropdownMenuItem(
                              value: cabinet,
                              key: Key(cabinet.key),
                              child: Text(cabinet.cabinetName),
                            );
                          }).toList(),
                          onChanged: (val) => setState(
                                () => selectedCabinet = val,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0XffAEEF85),
                            shadowColor: Color(0Xff8685EF),
                            elevation: 15,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            textStyle: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              final progress = ProgressHUD.of(context);
                              progress.showWithText("Adding drawer ..");
                              drawerId = uuid.v1();
                              String cabinetImageName = basename(_image.path);
                              await widget.onCreate(
                                  drawerName,
                                  drawerId,
                                  drawerSize,
                                  drawerDescription,
                                  cabinetImageName,
                                  _image,
                                  _user.uid,
                                  selectedCabinet.key);
                              selectedCabinet = null;
                              progress.dismiss();
                              Navigator.pop(context);
                            }
                          },
                          child: new Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "Add Drawer",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }

  }
}
