import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterNew extends StatefulWidget {
  final Function toggleView;
  RegisterNew({this.toggleView});

  @override
  _RegisterNewState createState() => _RegisterNewState();
}

class _RegisterNewState extends State<RegisterNew> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscuredText = true;
  String email = '';
  String password = '';
  String cPassword = '';
  String error = '';
  String fName = '';

  void _showMaterialDialog(message, titleMessage) {
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

  void _toggle() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: ProgressHUD(
        indicatorWidget: Container(
          child: SpinKitWave(
            color: Colors.green,
          ),
        ),
        child: Builder(
          builder: (context) => Container(
            child: SizedBox(
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    child: Center(
                      child: Image.asset(
                        "assets/images/img_app_logo.png",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter a full name";
                                  }
                                  return null;
                                },
                                obscureText: false,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: 'Jon Doe',
                                  prefixIcon: new Icon(Icons.person,
                                      color: Color(0Xff9cacbf)),
                                  labelText: "Enter Full Name",
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Color(0Xff9cacbf),
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    fName = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter an email";
                                  } else if (!EmailValidator.validate(val)) {
                                    return "Please enter a valid email";
                                  }
                                  return null;
                                },
                                obscureText: false,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: 'abc@xyz.com',
                                  prefixIcon: new Icon(Icons.email,
                                      color: Color(0Xff9cacbf)),
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                  labelText: "Enter Email",
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Color(0Xff9cacbf),
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter a password";
                                  } else if (val.length < 6) {
                                    return "Please enter password at least 6 char long";
                                  }
                                  return null;
                                },
                                obscureText: _obscuredText,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    hintText: '**********',
                                    hintStyle: TextStyle(color: Colors.grey[500]),
                                    prefixIcon: new Icon(Icons.lock,
                                        color: Color(0Xff9cacbf)),
                                    labelText: "Enter Password",
                                    fillColor: Colors.white,
                                    labelStyle: TextStyle(
                                      color: Color(0Xff9cacbf),
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.remove_red_eye,
                                            color: _obscuredText
                                                ? Colors.black12
                                                : Color(0Xff9cacbf)),
                                        onPressed: _toggle)),
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please confirm password";
                                  } else if (val != password) {
                                    return "Password does not match";
                                  }
                                  return null;
                                },
                                obscureText: true,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: '**********',
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                  prefixIcon: new Icon(Icons.lock,
                                      color: Color(0Xff9cacbf)),
                                  labelText: "Re-Enter Password",
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Color(0Xff9cacbf),
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    cPassword = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: new Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                        color: Color(0Xff2b6684),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    onPressed: () => {widget.toggleView()},
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // background color
                                  primary: Color(0Xff00A09A),
                                  elevation: 10,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(10.0),
                                  ),
                                  textStyle: TextStyle(
                                      fontSize: 50, fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    final pregress = ProgressHUD.of(context);
                                    pregress.showWithText("Signing up ...");
                                    dynamic result = await _authService
                                        .registerWithEmailAndPassword(
                                            email, password, fName);
                                    if (result.user == null) {
                                      print("==> " + result.error);
                                      _showMaterialDialog(result.error, "Error");
                                    }
                                    pregress.dismiss();
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
                                          "Sign Up",
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
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
