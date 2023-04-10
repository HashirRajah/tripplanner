import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'footer_buttons.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class GetStartedFooter extends StatelessWidget {
  const GetStartedFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: spacing_16, top: spacing_16, right: spacing_16),
      child: ListView(
        children: <Widget>[
          const FooterButton(text: 'Sign Up'),
          addVerticalSpace(spacing_16),
          const FooterButton(text: 'Login'),
        ],
      ),
    );
  }
}
