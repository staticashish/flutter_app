import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/authenticate/sign_in_new.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String email = '';
  String password = '';

  _showMaterialDialog(message, titleMessage) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: Text(titleMessage),
          content: Text(message),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue[800], Colors.white12, Colors.white54, Colors.white60]
              )
            ),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Flutter",
                          style: GoogleFonts.lato(
                            color: Colors.blueGrey[400],
                            fontSize: 30.0
                          )
                        ),
                        Text(
                          "App",
                          style: GoogleFonts.lato(
                            color: Colors.blueGrey[400],
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    )
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
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
                              hintText: 'abc@xyz.com',
                              hintStyle: GoogleFonts.lato(color: Colors.grey[500]),
                              labelText: "Enter Email",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              )
                            ),
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
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
                              hintStyle: GoogleFonts.lato(color: Colors.grey[500]),
                              labelText: "Enter Password",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              )
                            ),
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: new FlatButton(
                          child: new Text(
                            "Forgot Password?",
                            style: GoogleFonts.lato(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          onPressed: () => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => SignInNew())
                            )
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 50.0, right: 50.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0),
                            ),
                            color: Colors.deepPurple[300],
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
                                dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                                if(result.user == null) {
                                  print("==> "+result.error);
                                  _showMaterialDialog(result.error, "Error");
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
                                      "Login",
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
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(border: Border.all(width: 0.25)),
                          ),
                        ),
                        Text(
                          "OR CONNECT WITH",
                          style: GoogleFonts.lato(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(border: Border.all(width: 0.25)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.only(right: 8.0),
                            alignment: Alignment.center,
                            child: new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new FlatButton(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0),
                                    ),
                                    color: Color(0Xff3B5998),
                                    onPressed: () => {},
                                    child: new Container(
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Expanded(
                                            child: new FlatButton(
                                              onPressed: ()=>{},
                                              padding: EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 20.0,
                                              ),
                                              child: new Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  Icon(
                                                    const IconData(0xea90,
                                                        fontFamily: 'icomoon'),
                                                    color: Colors.white,
                                                    size: 15.0,
                                                  ),
                                                  Text(
                                                    "FACEBOOK",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.lato(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.only(left: 8.0),
                            alignment: Alignment.center,
                            child: new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new FlatButton(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0),
                                    ),
                                    color: Color(0Xff3cba54),
                                    onPressed: () => {},
                                    child: new Container(
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Expanded(
                                            child: new FlatButton(
                                              onPressed: ()=>{},
                                              padding: EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 20.0,
                                              ),
                                              child: new Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  Icon(
                                                    const IconData(0xea88,
                                                        fontFamily: 'icomoon'),
                                                    color: Colors.white,
                                                    size: 15.0,
                                                  ),
                                                  Text(
                                                    "GOOGLE",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.lato(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an account ?',
                          style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        FlatButton(
                          child: Text(
                            'Register',
                            style: GoogleFonts.lato(
                                color: Colors.redAccent,
                                fontSize: 13,
                                fontWeight: FontWeight.w600)
                          ),
                          onPressed: () {
                            widget.toggleView();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )),
          )
      ),
    );
  }
}