import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/firebase_result.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future registerWithEmailAndPassword(String email, String password, String name) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => null);
      User user  = _auth.currentUser;
      user.updateProfile(displayName: name);
      await DatabaseService(docId: user.uid)
          .updateUserData(name, user.email);
      return _firebaseResultFromResponse(user, null);
    } catch (e) {
      print(e.toString());
      return _firebaseResultFromResponse(null, e.message);
    }
  }

  Future signInWithGoogle() async {

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
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