import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Register Method
  Future register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// Login Method
  Future login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// Google Signin
  Future signWithGoogle() async {
    User? user;

    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        user = userCredential.user;
        if (userCredential.additionalUserInfo!.isNewUser) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(user!.email)
              .set({"name": user.displayName, "email": user.email});
        }
        return null;
      } on FirebaseAuthException catch (e) {
        return e.message;
      }
    }

    return user;
  }

  /// Forgot password
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// Logout
  Future logout() async {
    User user = _auth.currentUser!;
    try {
      if (user.providerData[0].providerId == "google.com") {
        _googleSignIn.disconnect();
      }
    } catch (e) {
      print(e);
    }

    _auth.signOut();
  }
}
