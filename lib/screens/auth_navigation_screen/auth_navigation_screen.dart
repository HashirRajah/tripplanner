import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/screens/login_screen/login_screen.dart';
import 'package:tripplanner/screens/sign_up_screen/sign_up_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AuthNavigationScreen extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/secure.svg';
  final String screenTitle = 'Authentication needed';
  //
  const AuthNavigationScreen({super.key});
  //
  void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: spacing_24, vertical: spacing_32),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    svgFilePath,
                    height: getXPercentScreenHeight(30, screenHeight),
                  ),
                  addVerticalSpace(spacing_8),
                  Text(
                    screenTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  addVerticalSpace(spacing_64),
                  ElevatedButtonWrapper(
                    childWidget: ElevatedButton(
                      onPressed: () =>
                          navigateToScreen(context, const SignUpScreen()),
                      child: const Text('Sign Up'),
                    ),
                  ),
                  addVerticalSpace(spacing_16),
                  ElevatedButtonWrapper(
                    childWidget: ElevatedButton(
                      onPressed: () =>
                          navigateToScreen(context, const LoginScreen()),
                      child: const Text('Sign In'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
