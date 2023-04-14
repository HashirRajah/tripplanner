import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/screens/sign_up_screen/email_sign_up_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/question_action.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EmailSignUpScreen extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/signup.svg';
  final String screenTitle = 'Sign Up';
  //
  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  //
  const EmailSignUpScreen({super.key});

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
                    EmailSignUpForm(title: screenTitle),
                    addVerticalSpace(spacing_16),
                    QuestionAction(
                      question: 'Choose another method?',
                      action: 'Go Back',
                      actionNavigation: navigateBack,
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
