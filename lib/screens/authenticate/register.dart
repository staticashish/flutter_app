import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/authenticate/authenticate.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String cPassword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.yellowAccent, Colors.white70, Colors.white24, Colors.white12]
              )
          ),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(75.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Flutter",
                                style: GoogleFonts.lato(
                                    color: Colors.redAccent, fontSize: 30.0)),
                            Text(
                              "App",
                              style: GoogleFonts.lato(
                                  color: Colors.redAccent,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                    Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              "EMAIL",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              validator: (val) {
                                if(val.isEmpty) {
                                  return "Please enter an email";
                                } else if(!EmailValidator.validate(val)) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                              obscureText: false,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: 'someone@something.com',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              onChanged: (val) {
                                email = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.0,
                    ),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              "Password",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              validator: (val) {
                                if(val.isEmpty) {
                                  return "Please enter a password";
                                } else if(val.length < 6) {
                                  return "Please enter password at least 6 char long";
                                }
                                return null;
                              },
                              obscureText: true,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: '**********',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              onChanged: (val) {
                                password = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.0,
                    ),
                    Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              "Confirm Password",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    new Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              validator: (val) {
                                if(val.isEmpty) {
                                  return "Please confirm password";
                                } else if(val != password) {
                                  return "Password does not match";
                                }
                                return null;
                              },
                              obscureText: true,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: '**********',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              onChanged: (val) {
                                cPassword = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.0,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: new FlatButton(
                            child: new Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            onPressed: () {
                              widget.toggleView();
                            },
                          ),
                        ),
                      ],
                    ),
                    new Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 20.0),
                        alignment: Alignment.center,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new FlatButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                color: Colors.redAccent,
                                onPressed: () async {
                                  if(_formKey.currentState.validate()){
                                   dynamic result = await _authService.registerWithEmailAndPassword(email, password, null);
                                   if(result.user == null) {
                                     print(result.error);
                                   }
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
                                      new Expanded(
                                        child: Text(
                                          "SIGN UP",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                )),
          )),
    );
  }
}
