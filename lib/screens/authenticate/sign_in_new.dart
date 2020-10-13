import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInNew extends StatefulWidget {

  final Function toggleView;
  SignInNew({ this.toggleView});

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
            child: Text(titleMessage,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
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
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('$provider Button Pressed!'),
      backgroundColor: Colors.black26,
      duration: Duration(milliseconds: 400),
    ));
  }

  void _toggle(){
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blue[200],
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Color(0Xff334a7d),
                  Color(0Xff2b3c63),
                  Color(0Xff1b2133),
                  Color(0Xff1b2133)]
            )
        ),
        child: Column(
          children: [
            Flexible(
                flex: 1,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.account_balance,
                                size: 40,
                                color: Colors.white,
                              )
                          ),
                          TextSpan(
                              text: ' Flutter',
                              style: TextStyle(fontSize: 40)
                          ),
                          TextSpan(
                              text: 'App',
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)
                          )
                        ]
                    ),
                  ),
                )
            ),
            Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(20.0),
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              TextFormField(
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
                                  prefixIcon: new Icon(Icons.email, color: Color(0Xff334a7d)),
                                  hintStyle: GoogleFonts.lato(color: Colors.grey[500]),
                                  labelText: "Enter Email",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              SizedBox(height: 30.0),
                              TextFormField(
                                validator: (val) {
                                  if(val.isEmpty) {
                                    return "Please enter a password";
                                  } else if(val.length < 6) {
                                    return "Please enter password at least 6 char long";
                                  }
                                  return null;
                                },
                                obscureText: _obscuredText,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    hintText: '**********',
                                    hintStyle: GoogleFonts.lato(color: Colors.grey[500]),
                                    prefixIcon: new Icon(Icons.lock, color: Color(0Xff334a7d)),
                                    labelText: "Enter Password",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                            Icons.remove_red_eye,
                                            color: _obscuredText ? Colors.black12 : Colors.black54
                                        ),
                                        onPressed: _toggle
                                    )
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                              SizedBox(height: 5.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    child: new Text(
                                      "Forgot Password?",
                                      style: GoogleFonts.lato(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    onPressed: () => {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => SignInNew())
                                      )
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0,),
                              RaisedButton(
                                elevation: 10,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                color: Color(0Xff2b3c63),
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
                                      Expanded(
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
                              SizedBox(height: 10.0,),
                              Row(
                                children: <Widget>[
                                  Expanded(
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
                                  Expanded(
                                    child: new Container(
                                      margin: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(border: Border.all(width: 0.25)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0,),
                              Column(
                                children: <Widget>[
                                  SignInButton(
                                    Buttons.Google,
                                    elevation: 10,
                                    onPressed: () {
                                      _showButtonPressDialog(context, 'Google (mini)');
                                    },
                                  ),
                                  SignInButton(
                                    Buttons.Facebook,
                                    elevation: 10,
                                    onPressed: () {
                                      _showButtonPressDialog(context, 'Facebook (mini)');
                                    },
                                  ),
                                ],
                              ),
                              Row(
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
                              )

                            ],
                          ),
                        )
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
