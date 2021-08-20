import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
import 'package:flutter_app/screens/custom/image_selector.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class RoomForm extends StatefulWidget {
  final Function onCreate;

  RoomForm({this.onCreate});

  @override
  _RoomFormState createState() => _RoomFormState();
}

class _RoomFormState extends State<RoomForm> {
  final _formKey = GlobalKey<FormState>();
  final uuid = Uuid();
  String roomName;
  String roomId;
  String roomSize;
  String roomDescription;
  PickedFile _image;

  _onImageSelect(PickedFile file) {
    this._image = file;
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Room",
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
                            return "Please enter a room name";
                          }
                          return null;
                        },
                        obscureText: false,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'Living room',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          labelText: "Enter Room Name",
                          labelStyle: TextStyle(
                            color: Color(0Xff9cacbf),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            roomName = val;
                          });
                        },
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please enter an room size";
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: '100',
                          labelText: "Enter Room Size",
                          labelStyle: TextStyle(
                            color: Color(0Xff9cacbf),
                          ),
                          suffixText: 'm²',
                          suffixStyle: TextStyle(color: Color(0Xff9cacbf)),
                        ),
                        onChanged: (val) {
                          setState(() {
                            roomSize = val;
                          });
                        },
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please enter a room description";
                          }
                          return null;
                        },
                        obscureText: false,
                        maxLines: 2,
                        maxLength: 200,
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'Description of living room',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          labelText: "Enter Room Description",
                          labelStyle: TextStyle(
                            color: Color(0Xff9cacbf),
                          ),
                          fillColor: Colors.white,
                        ),
                        onChanged: (val) {
                          setState(() {
                            roomDescription = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
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
                            print("context : " + context.toString());
                            final progress = ProgressHUD.of(context);
                            progress.showWithText("Adding room ...");
                            roomId = uuid.v1();
                            String roomImageName = basename(_image.path);
                            await widget.onCreate(
                                roomName,
                                roomId,
                                roomSize,
                                roomDescription,
                                roomImageName,
                                _image,
                                user.uid);
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
                                  "Add Room",
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
  }
}
