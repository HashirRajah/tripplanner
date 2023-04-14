import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    // get current user
    final User? user = _auth.currentUser;
    // send notification email;
    await user?.sendEmailVerification();
  }

  // sign up with google
  Future signUpWithGoogle() async {}

  // sign up with facebook
  Future signUpWithFacebook() async {}

  // sign in methods
  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  // sign in with google
  Future signInWithGoogle() async {}

  // sign in with facebook
  Future signInWithFacebook() async {}

  // sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // user stream
}
