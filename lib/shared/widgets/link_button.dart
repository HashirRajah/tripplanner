import 'package:flutter/material.dart';
import 'package:tripplanner/screens/password_reset_screen/password_reset_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class ForgotPasswordButton extends StatelessWidget {
  //
  final String text;
  //
  const ForgotPasswordButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResetPasswordScreen(),
              ),
            );
          },
          style: linkButtonStyle,
          child: Text(text),
        ),
      ],
    );
  }
}
