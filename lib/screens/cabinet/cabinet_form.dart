import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final List<String> sugars = ['0', '1', '2', '3', '4'];

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
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
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
                      prefixIcon:
                          new Icon(Icons.person, color: Color(0Xff334a7d)),
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
                  SizedBox(height: 5.0),
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
                      prefixIcon:
                          new Icon(Icons.email, color: Color(0Xff334a7d)),
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
                  SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    value: roomName,
                    //decoration: textInputDecoration,
                    decoration: InputDecoration(
                      hintText: 'Please Select',
                      prefixIcon:
                          new Icon(Icons.email, color: Color(0Xff334a7d)),
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
                        cabinetId = uuid.v1();
                        widget.onCreate(cabinetName, cabinetId, cabinetSize, _user.uid, selectedRoom.key);
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
      );
    } else {
      return CircularProgressIndicator(
      );
    }
  }
}
