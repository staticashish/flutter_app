import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
import 'package:flutter_app/screens/custom/image_selector.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CabinetForm extends StatefulWidget {
  final Function onCreate;

  CabinetForm({this.onCreate});

  @override
  _CabinetFormState createState() => _CabinetFormState();
}

class _CabinetFormState extends State<CabinetForm> {
  final _formKey = GlobalKey<FormState>();
  final uuid = Uuid();
  String cabinetName;
  String cabinetId;
  String cabinetSize;
  String cabinetDescription;
  String roomName;
  RoomModel selectedRoom;
  PickedFile _image;

  _onImageSelect(PickedFile file) {
    this._image = file;
  }

  @override
  Widget build(BuildContext context) {
    final _rooms = Provider.of<List<RoomModel>>(context);
    final _user = Provider.of<User>(context);
    if (_rooms != null && _rooms.length > 0) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Add Cabinet',
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
                            hintText: 'Kitchen Cabinet',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            labelText: "Enter Cabinet Name",
                            labelStyle: TextStyle(
                              color: Color(0Xff9cacbf),
                            ),
                            fillColor: Colors.white,
                          ),
                          onChanged: (val) {
                            setState(() {
                              cabinetName = val;
                            });
                          },
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter an cabinet size";
                            }
                            return null;
                          },
                          obscureText: false,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            hintText: '100X200',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            labelText: "Enter Cabinet Size",
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Color(0Xff9cacbf),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              cabinetSize = val;
                            });
                          },
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter an cabinet description";
                            }
                            return null;
                          },
                          obscureText: false,
                          maxLines: 2,
                          maxLength: 200,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            hintText: 'cabinet description',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            labelText: "Enter Cabinet Description",
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Color(0Xff9cacbf),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              cabinetDescription = val;
                            });
                          },
                        ),
                        DropdownButtonFormField(
                          value: selectedRoom != null ? selectedRoom : null,
                          decoration: InputDecoration(
                            hintText: 'Please Select',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            labelText: "Select Room",
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Color(0Xff9cacbf),
                            ),
                          ),
                          items: _rooms.map((room) {
                            return DropdownMenuItem(
                              value: room,
                              key: Key(room.key),
                              child: Text(room.roomName),
                            );
                          }).toList(),
                          onChanged: (val) => setState(
                            () => selectedRoom = val,
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
                              progress.showWithText("Adding cabinet ..");
                              cabinetId = uuid.v1();
                              String cabinetImageName = basename(_image.path);
                              await widget.onCreate(
                                  cabinetName,
                                  cabinetId,
                                  cabinetSize,
                                  cabinetDescription,
                                  cabinetImageName,
                                  _image,
                                  _user.uid,
                                  selectedRoom.key);
                              selectedRoom = null;
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
                                    "Add Cabinet",
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
