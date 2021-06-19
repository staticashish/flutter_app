import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/custom/custom_app_bar.dart';
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
  bool _isLoading = false;

  _imgFromCamera() async {
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 150.0,
    );
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Gallary'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Room",
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: 150,
                        height: 150,
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  File(_image.path),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_enhance,
                                  color: Colors.grey[800],
                                  size: 50,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 20.0,
                    thickness: 5.0,
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
                  SizedBox(height: 10.0),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please enter an room size";
                      }
                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  SizedBox(height: 10.0),
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
                    height: 30.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //primary: Color(0Xff00A09A),
                      elevation: 10,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      textStyle:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          this._isLoading = true;
                        });
                        roomId = uuid.v1();
                        String roomImageName = basename(_image.path);
                        await widget.onCreate(roomName, roomId, roomSize,
                            roomDescription, roomImageName, _image, user.uid);
                        setState(() {
                          this._isLoading = false;
                        });
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
                                  color: Colors.white,
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
    );
  }
}
