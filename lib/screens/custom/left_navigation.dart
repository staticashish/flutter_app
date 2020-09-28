import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/custom/custom_list_tile.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class LeftNavigation extends StatefulWidget {
  @override
  _LeftNavigationState createState() => _LeftNavigationState();
}

class _LeftNavigationState extends State<LeftNavigation> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0Xff334a7d),
                          Color(0Xff2b3c63),
                        ]
                    )
                ),
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        minRadius: 40,
                        maxRadius: 50,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                          'assets/images/img_person_default.jpg',
                        ),
                      ),
                      SizedBox(height: 10.0),
                      RichText(
                        text: TextSpan(
                            text: user.email,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                        ),
                      )
                    ],
                  ),
                )
            ),
            CustomListTile(Icons.person,
                'Profile',
                    () {
                  print('tap profile');
                }
            ),
            CustomListTile(Icons.settings,
                'Setting',
                    () {
                  print('tap setting');
                }
            ),
            CustomListTile(Icons.lock,
                'Logout',
                    () async {
                  await _authService.signOut();
                }
            )
          ],
        ),
      )
    );
  }
}
