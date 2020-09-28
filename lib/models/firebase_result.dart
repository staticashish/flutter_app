import 'package:firebase_auth/firebase_auth.dart';

class FirebaseResult {
  final User user;
  final String error;

  FirebaseResult({this.user, this.error});
}