import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class SignInNew extends StatefulWidget {
  final Function toggleView;

  SignInNew({this.toggleView});

  @override
  _SignInNewState createState() => _SignInNewState();
}

class _SignInNewState extends State<SignInNew> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscuredText = true;
  String email = '';
  String password = '';

  void _showMaterialDialog(message, titleMessage) {
    showCupertinoDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  titleMessage,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              content: Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            ));
  }

  void _showButtonPressDialog(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$provider Button Pressed!'),
      backgroundColor: Colors.black26,
      duration: Duration(milliseconds: 400),
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
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
                                        return "Please enter an email";
                                      } else if (!EmailValidator.validate(
                                          val)) {
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
                                      labelText: "Enter Email",
                                      labelStyle: TextStyle(
                                        color: Color(0Xff9cacbf),
                                      ),
                                      fillColor: Colors.white,
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
                                      prefixIcon: new Icon(Icons.lock,
                                          color: Color(0Xff9cacbf)),
                                      labelText: "Enter Password",
                                      labelStyle: TextStyle(
                                        color: Color(0Xff9cacbf),
                                      ),
                                      fillColor: Colors.white,
                                      suffixIcon: IconButton(
                                          icon: Icon(Icons.remove_red_eye_sharp,
                                              color: _obscuredText
                                                  ? Colors.black12
                                                  : Color(0Xff9cacbf)),
                                          onPressed: _toggle),
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        password = val;
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
                                          "Forgot Password?",
                                          style: TextStyle(
                                            color: Color(0Xff2b6684),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.0,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                        onPressed: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignInNew()))
                                        },
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
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                      ),
                                      textStyle: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        final progress =
                                            ProgressHUD.of(context);
                                        progress.showWithText("Signing in ...");
                                        dynamic result = await _authService
                                            .signInWithEmailAndPassword(
                                                email, password);
                                        if (result.user == null) {
                                          print("==> " + result.error);
                                          _showMaterialDialog(
                                              result.error, "Error");
                                        }
                                        progress.dismiss();
                                      }
                                    },
                                    child: new Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20.0,
                                        horizontal: 20.0,
                                      ),
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Login",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: new Container(
                                          margin: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 0.25)),
                                        ),
                                      ),
                                      Text(
                                        "OR CONNECT WITH",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Expanded(
                                        child: new Container(
                                          margin: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 0.25)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SignInButton.mini(
                                        buttonType: ButtonType.google,
                                        elevation: 10,
                                        onPressed: () async {
                                          final progress =
                                              ProgressHUD.of(context);
                                          progress.show();
                                          dynamic result = await _authService
                                              .signInWithGoogle();
                                          if (result.user == null) {
                                            print("==> " + result.error);
                                            _showMaterialDialog(
                                                result.error, "Error");
                                          }
                                          progress.dismiss();
                                        },
                                      ),
                                      SignInButton.mini(
                                        buttonType: ButtonType.facebook,
                                        elevation: 10,
                                        onPressed: () {
                                          _showButtonPressDialog(
                                              context, 'Facebook (mini)');
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Don\'t have an account ?',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 1,
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Register',
                                          style: TextStyle(
                                              color: Color(0Xff2b6684),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        onPressed: () {
                                          widget.toggleView();
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
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
