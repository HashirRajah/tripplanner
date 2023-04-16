import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/screens/password_reset_screen/password_reset_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ResetPasswordScreen extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/forgot_password.svg';
  final String screenTitle = 'Reset Password';
  //
  const ResetPasswordScreen({super.key});

  //
  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    Orientation screenOrientation = getScreenOrientation(context);
    //
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: spacing_24, vertical: spacing_8),
                child: Center(
                  child: Column(
                    crossAxisAlignment:
                        screenOrientation == Orientation.portrait
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: SvgPicture.asset(
                          svgFilePath,
                          height: getXPercentScreenHeight(30, screenHeight),
                        ),
                      ),
                      addVerticalSpace(spacing_8),
                      Text(
                        screenTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      addVerticalSpace(spacing_16),
                      ResetPasswordForm(
                        title: screenTitle,
                      ),
                      addVerticalSpace(spacing_16),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: linkButtonStyle,
                          child: const Text('Go Back'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
