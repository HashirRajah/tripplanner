import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/screens/auth_navigation_screen/auth_navigation_screen.dart';
import 'package:tripplanner/screens/email_verification_screen/email_verification_screen.dart';
import 'package:tripplanner/screens/home_screens/home.dart';
import 'package:tripplanner/screens/login_screen/login_screen.dart';
import 'package:tripplanner/screens/sign_up_screen/sign_up_screen.dart';
import 'package:tripplanner/screens/wrapper_screen/wrapper_screen.dart';
import 'utils/helper_functions.dart';
import 'shared/constants/theme_constants.dart';
import 'screens/onboarding_screens/onboarding_screen.dart';

class Tripplanner extends StatelessWidget {
  //
  final _auth = FirebaseAuth.instance;
  //
  Tripplanner({super.key});
  //
  final String title = 'Tripplanner';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: _auth.authStateChanges(),
      child: MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const WrapperScreen(), //OnboardingScreen(),
      ),
    );
  }
}
