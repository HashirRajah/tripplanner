import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripplanner/services/shared_preferences_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'page_view_models.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  //
  final List<PageViewModel> onboardingPages = [
    welcome(),
    explore(),
    find(),
    trips(),
    getStarted(),
  ];
  //
  final DotsDecorator dotsDecorator = DotsDecorator(
    color: white_60,
    activeColor: green_30,
    size: const Size(spacing_8, spacing_8),
    activeSize: const Size(spacing_16, spacing_16),
  );
  //
  final ButtonStyle nextButtonStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(white_60),
  );
  //
  final ButtonStyle skipButtonStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(white_60),
  );

  @override
  Widget build(BuildContext context) {
    //
    final SharedPreferences prefs = SharedPreferencesService.prefs;
    //
    return IntroductionScreen(
      globalBackgroundColor: green_10,
      dotsDecorator: dotsDecorator,
      nextStyle: nextButtonStyle,
      skipStyle: skipButtonStyle,
      pages: onboardingPages,
      showNextButton: true,
      showSkipButton: true,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward_rounded),
      showDoneButton: false,
      onChange: (value) async {
        if (value == onboardingPages.length - 1) {
          await prefs.setBool('new-user', false);
        }
      },
    );
  }
}
