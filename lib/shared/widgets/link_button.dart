import 'package:flutter/material.dart';
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
          onPressed: () {},
          style: linkButtonStyle,
          child: Text(text),
        ),
      ],
    );
  }
}
