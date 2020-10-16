import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/storage_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class RoomForm extends StatefulWidget {
  final Function onCreate;
  final Function onUploadRoomImage;

  RoomForm({this.onCreate, this.onUploadRoomImage});

  @override
  _RoomFormState createState() => _RoomFormState();
}

class _RoomFormState extends State<RoomForm> {
  final _formKey = GlobalKey<FormState>();
  final uuid = Uuid();
  String roomName;
  String roomId;
  String roomSize;
  String roomImageUrl;
  PickedFile _image;

  _imgFromCamera() async {
    PickedFile image = await ImagePicker().getImage(source: ImageSource.camera);
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
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallary'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
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
        });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0Xff5f72a9),
        elevation: 10.0,
        title: Text('Add Room'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Container(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          width: 200,
                          height: 200,
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
                  ),
                  const Divider(
                    height: 100.0,
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
                      //prefixIcon: new Icon(Icons.person, color: Color(0Xff334a7d)),
                      hintStyle: GoogleFonts.lato(color: Colors.grey[500]),
                      labelText: "Enter Room Name",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.blueGrey,
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        roomName = val;
                      });
                    },
                  ),
                  SizedBox(height: 30.0),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please enter an room size";
                      }
                      return null;
                    },
                    obscureText: false,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: '100m2',
                      //prefixIcon: new Icon(Icons.email, color: Color(0Xff334a7d)),
                      hintStyle: GoogleFonts.lato(color: Colors.grey[500]),
                      labelText: "Enter Room Size",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.blueGrey, width: 2.0),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        roomSize = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  RaisedButton(
                    elevation: 10,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    color: Color(0Xff2b3c63),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        roomId = uuid.v1();
                        print(_image.path);
                        roomImageUrl = await widget.onUploadRoomImage(
                          File(_image.path),
                          user.uid,
                        );
                        widget.onCreate(
                            roomName, roomId, roomSize, roomImageUrl, user.uid);
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
                              style: GoogleFonts.lato(
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
