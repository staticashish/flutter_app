import 'package:flutter/material.dart';
import 'package:flutter_app/screens/wrapper.dart';
import 'package:splashscreen/splashscreen.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: SplashScreen(
          seconds: 5,
          navigateAfterSeconds: Wrapper(),
          loaderColor: Colors.black,
          image: Image.asset("assets/images/gif_shelves.gif"),
          title: Text('FlutterApp',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Color(0Xff2b3c63)
            ),
          ),
          photoSize: 100,
          gradientBackground: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0Xffdfe1ee),
                Color(0Xffdfe1ee),
                Color(0Xffffffff)
              ]
          ),
        ),
      ),
    );
  }
}
