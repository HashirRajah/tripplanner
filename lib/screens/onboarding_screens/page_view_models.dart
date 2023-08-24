import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'get_started_footer.dart';

// page decoration
PageDecoration pageDecoration = PageDecoration(
  titleTextStyle: onboardingTitleTextStyle,
  bodyTextStyle: onboardingBodyTextStyle,
  imagePadding:
      const EdgeInsets.fromLTRB(spacing_24, spacing_24, spacing_24, spacing_8),
);

// welcome
PageViewModel welcome() {
  //
  const String helloAnimationFilePath = 'assets/lottie_files/hello.json';
  //
  return PageViewModel(
    title: 'Welcome to Tripplanner',
    body: 'Plan your next adventure easily',
    image: Lottie.asset(helloAnimationFilePath),
    decoration: pageDecoration,
  );
}

// explore
PageViewModel explore() {
  //
  const String helloAnimationFilePath = 'assets/lottie_files/explore.json';
  //
  return PageViewModel(
    title: 'Explore',
    body: 'Find your next destination with personalized recommendations',
    image: Lottie.asset(helloAnimationFilePath),
    decoration: pageDecoration,
  );
}

// find
PageViewModel find() {
  //
  const String helloAnimationFilePath = 'assets/lottie_files/travel.json';
  //
  return PageViewModel(
    title: 'Find',
    body: 'Get Travel information for your trip destinations',
    image: Lottie.asset(helloAnimationFilePath),
    decoration: pageDecoration,
  );
}

// trips
PageViewModel trips() {
  //
  const String helloAnimationFilePath = 'assets/lottie_files/documents.json';
  //
  return PageViewModel(
    title: 'Trips',
    body:
        'Create and share trips, manage travel documents, add notes, set reminders and add visits',
    image: Lottie.asset(helloAnimationFilePath),
    decoration: pageDecoration,
  );
}

// get started
PageViewModel getStarted() {
  //
  const String helloAnimationFilePath = 'assets/lottie_files/register.json';
  //
  return PageViewModel(
    title: 'Get Started',
    body:
        'To start using Tripplanner, Sign Up to create an account or Sign In if you already have one',
    image: Lottie.asset(helloAnimationFilePath),
    decoration: pageDecoration,
    footer: const GetStartedFooter(),
  );
}
