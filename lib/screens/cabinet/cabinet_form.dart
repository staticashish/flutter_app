import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
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
  String roomName;
  RoomModel selectedRoom;
  PickedFile _image;
  bool _isLoading = false;

  _imgFromCamera() async {
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 250.0,
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _rooms = Provider.of<List<RoomModel>>(context);
    final _user = Provider.of<User>(context);
    if (_rooms != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0Xff5f72a9),
          elevation: 10.0,
          title: Text('Add Cabinet'),
        ),
        body: LoadingOverlay(
          child: SingleChildScrollView(
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
                      const Divider(
                        height: 50.0,
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
                          hintStyle: GoogleFonts.lato(color: Colors.grey[500]),
                          labelText: "Enter Cabinet Name",
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
                            cabinetName = val;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
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
                          hintStyle: GoogleFonts.lato(color: Colors.grey[500]),
                          labelText: "Enter Cabinet Size",
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
                            cabinetSize = val;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      DropdownButtonFormField(
                        value: roomName,
                        //decoration: textInputDecoration,
                        decoration: InputDecoration(
                          hintText: 'Please Select',
                          hintStyle: GoogleFonts.lato(color: Colors.grey[500]),
                          labelText: "Select Room",
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
                        items: _rooms.map((room) {
                          return DropdownMenuItem(
                            value: room,
                            child: Text(room.roomName),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => selectedRoom = val),
                      ),
                      SizedBox(height: 10.0),
                      RaisedButton(
                        elevation: 10,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        color: Color(0Xff2b3c63),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              this._isLoading = true;
                            });
                            cabinetId = uuid.v1();
                            String cabinetImageName = basename(_image.path);
                            await widget.onCreate(
                                cabinetName,
                                cabinetId,
                                cabinetSize,
                                cabinetImageName,
                                _image,
                                _user.uid,
                                selectedRoom.key);
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
          isLoading: _isLoading,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
