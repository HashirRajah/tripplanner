import 'package:flutter/material.dart';
import 'package:tripplanner/utils/helper_functions.dart';

// spacing values for padding and margin
const double spacing_8 = 8.0;
const double spacing_16 = 16.0;
const double spacing_24 = 24.0;
const double spacing_32 = 32.0;
const double spacing_40 = 40.0;
const double spacing_48 = 48.0;
const double spacing_56 = 56.0;
const double spacing_64 = 64.0;

// colors
final Color green_10 = colorFromHexCode('#00425A');
final Color green_30 = colorFromHexCode('#1F8A70');
final Color white_60 = colorFromHexCode('#F7F7F7');

// onboarding text styles
final TextStyle onboardingTitleTextStyle = TextStyle(
  fontFamily: 'Pacifico',
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  letterSpacing: 3.0,
  color: white_60,
);

final TextStyle onboardingBodyTextStyle = TextStyle(
  color: white_60,
  fontSize: 18.0,
);

// onbaording sign up/ login text style
const TextStyle onboardingFooterTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);

// onbaording sign up/ login button style
final ButtonStyle onboardingFooterButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(green_30),
  foregroundColor: MaterialStateProperty.all<Color>(white_60),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(spacing_16)),
  textStyle: MaterialStateProperty.all<TextStyle>(onboardingFooterTextStyle),
  shape: MaterialStateProperty.all<StadiumBorder>(const StadiumBorder()),
  //minimumSize: MaterialStateProperty.all<Size>(const Size()),
);

// Floating action button theme
final FloatingActionButtonThemeData floatingActionButtonLightThemeData =
    FloatingActionButtonThemeData(
  backgroundColor: green_10,
  foregroundColor: white_60,
);

// Elevation button theme
final ElevatedButtonThemeData elevatedButtonLightThemeData =
    ElevatedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(green_10),
    foregroundColor: MaterialStateProperty.all<Color>(white_60),
  ),
);

// themes
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Montserrat',
  fontFamilyFallback: const ['Raleway', 'Pacifico'],
  scaffoldBackgroundColor: white_60,
  floatingActionButtonTheme: floatingActionButtonLightThemeData,
);
