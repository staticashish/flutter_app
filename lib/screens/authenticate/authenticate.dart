import 'package:flutter/material.dart';
import 'package:flutter_app/screens/authenticate/register.dart';
import 'package:flutter_app/screens/authenticate/register_new.dart';
import 'package:flutter_app/screens/authenticate/sign_in.dart';
import 'package:flutter_app/screens/authenticate/sign_in_new.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggelView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInNew(toggleView : toggelView);
    } else {
      return RegisterNew(toggleView : toggelView);
    }
  }
}