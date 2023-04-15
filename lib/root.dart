import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/screens/wrapper_screen/wrapper_screen.dart';
import 'shared/constants/theme_constants.dart';

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
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: _auth.authStateChanges(),
          initialData: _auth.currentUser,
        ),
      ],
      child: MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const WrapperScreen(), //OnboardingScreen(),
      ),
    );
  }
}
