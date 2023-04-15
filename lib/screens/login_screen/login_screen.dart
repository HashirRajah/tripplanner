import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/screens/login_screen/login_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/login.svg';
  final String screenTitle = 'Sign In';
  //
  const LoginScreen({super.key});

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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: spacing_24, vertical: spacing_8),
              child: Center(
                child: Column(
                  crossAxisAlignment: screenOrientation == Orientation.portrait
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: SvgPicture.asset(
                        svgFilePath,
                        height: getXPercentScreenHeight(20, screenHeight),
                      ),
                    ),
                    addVerticalSpace(spacing_8),
                    Text(
                      screenTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    addVerticalSpace(spacing_16),
                    LoginForm(
                      title: screenTitle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
