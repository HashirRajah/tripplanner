import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/screens/sign_up_screen/sign_up_screen.dart';
import 'package:tripplanner/screens/login_screen/login_screen.dart';

class FooterButton extends StatelessWidget {
  //
  final String text;
  //
  const FooterButton({super.key, required this.text});
  //
  void navigateToNewRoute(BuildContext context, String route) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            route == 'Sign Up' ? const SignUpScreen() : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.75,
      child: ElevatedButton(
        onPressed: () => navigateToNewRoute(context, text),
        style: onboardingFooterButtonStyle,
        child: Text(text),
      ),
    );
  }
}
