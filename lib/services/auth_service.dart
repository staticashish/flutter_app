import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/firebase_result.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseResult _firebaseResultFromResponse(User user, String error) {
    return user != null ? FirebaseResult(user: user, error: null) : FirebaseResult(user: null, error: error);
  }

  Stream<User> get user {
    return _auth.authStateChanges();
  }
  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result  = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
   try {
     UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
     return _firebaseResultFromResponse(userCredential.user, null);
   } catch (e){
     print(e.toString());
     return _firebaseResultFromResponse(null, e.message);
   }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _firebaseResultFromResponse(userCredential.user, null);
    } catch (e) {
      print(e.toString());
      return _firebaseResultFromResponse(null, e.message);
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch(e) {
      print(e.toString());
    }
  }

}