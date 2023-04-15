import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/screens/auth_navigation_screen/auth_navigation_screen.dart';
import 'package:tripplanner/screens/email_verification_screen/email_verification_screen.dart';
import 'package:tripplanner/screens/home_screens/home.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // pop any routes from stack
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Navigator.of(context).popUntil((route) => route.isFirst);
    // });
    //
    final User? user = Provider.of<User?>(context);
    debugPrint(user?.displayName);
    // user not logged in
    if (user == null) {
      return const AuthNavigationScreen();
    }
    // if user did not verify email
    final bool verifiedUser = user.emailVerified;
    //
    if (!verifiedUser) {
      return const EmailVerificationScreen();
    }
    //
    return const Home();
  }
}
