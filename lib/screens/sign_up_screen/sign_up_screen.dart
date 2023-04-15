import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/screens/login_screen/login_screen.dart';
import 'package:tripplanner/screens/sign_up_screen/email_sign_up_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/facebook_sign_in.dart';
import 'package:tripplanner/shared/widgets/google_sign_in.dart';
import 'package:tripplanner/shared/widgets/question_action.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class SignUpScreen extends StatefulWidget {
  //
  final String svgFilePath = 'assets/svgs/pick.svg';
  final String screenTitle = 'Sign Up Options';
  //
  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  //
  void navigateToSignUpWithEmailAndPasswordScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const EmailSignUpScreen()));
  }

  //
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: spacing_24, vertical: spacing_32),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: SvgPicture.asset(
                      widget.svgFilePath,
                      height: getXPercentScreenHeight(25, screenHeight),
                    ),
                  ),
                  addVerticalSpace(spacing_8),
                  Text(
                    widget.screenTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  addVerticalSpace(spacing_64),
                  ElevatedButtonWrapper(
                    childWidget: ElevatedButton.icon(
                      onPressed: () => widget
                          .navigateToSignUpWithEmailAndPasswordScreen(context),
                      icon: const Icon(Icons.alternate_email),
                      label: const Text('Sign Up with Email'),
                    ),
                  ),
                  addVerticalSpace(spacing_8),
                  GoogleSignInButton(text: 'Up'),
                  addVerticalSpace(spacing_8),
                  FacebookSignIn(text: 'Up'),
                  addVerticalSpace(spacing_16),
                  QuestionAction(
                    question: 'Already have an account?',
                    action: 'Sign In',
                    actionNavigation: widget.navigateToLoginScreen,
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
