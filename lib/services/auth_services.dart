import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  // firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  // sign up methods
  // sign up with email and password
  Future signUpWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      //
      await credential.user?.updateDisplayName(username);
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  // email verification
  Future verifyEmail() async {
    try {
      // reload current user
      await _auth.currentUser?.reload();
      // get current user
      final User? user = _auth.currentUser;
      // send notification email if user is not verified
      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }
      }
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  // reset password
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  // sign up / sign in with google
  Future signInWithGoogle() async {
    // trigger auth flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // get auth credentials
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // create new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // sign in
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    return userCredential.user;
  }

  // sign up / sign in with facebook
  Future signInWithFacebook() async {
    try {
      // trigger sign-in-flow
      final LoginResult loginResult =
          await _facebookAuth.login(permissions: ['public_profile', 'email']);

      // get credentials
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // sign in
      UserCredential credential =
          await _auth.signInWithCredential(facebookAuthCredential);

      // return user
      return credential.user;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // sign in methods
  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  // sign out
  Future<void> signOut() async {
    String? provider = _auth.currentUser?.providerData[0].providerId;
    // check if user is logged in with google or facebook
    if (provider == 'google.com') {
      _googleSignIn.disconnect();
    } else if (provider == 'facebook.com') {
      _facebookAuth.logOut();
    }
    debugPrint(provider);
    await _auth.signOut();
  }

  // user stream
}
