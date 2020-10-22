import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/wrapper.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Container(
      child: SafeArea(
        child: SplashScreen(
          seconds: 3,
          navigateAfterSeconds: Wrapper(),
          loaderColor: Colors.black,
          image: Image.asset(
            "assets/images/img_app_logo.png",
          ),
          photoSize: 200,
          gradientBackground: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0Xffdfe1ee),
                Color(0Xffffffff)
              ]),
        ),
      ),
    );
  }
}
