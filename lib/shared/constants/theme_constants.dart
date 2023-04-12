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
final Color white_60 = colorFromHexCode('#f8f8ff');

// provider colors
final Color facebookBlue = colorFromHexCode('#4267B2');
final Color googleRed = colorFromHexCode('#DB4437');

// text styles
const TextStyle title = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.black,
  letterSpacing: 2.0,
);

// question-action text styles
final TextStyle questionActionTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.grey[400],
);

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
  fontSize: 16.0,
);

// text style for buttons
const TextStyle buttonTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

// onbaording sign up/ login button style
final ButtonStyle onboardingFooterButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(green_30),
  foregroundColor: MaterialStateProperty.all<Color>(white_60),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(spacing_16)),
  textStyle: MaterialStateProperty.all<TextStyle>(buttonTextStyle),
  shape: MaterialStateProperty.all<StadiumBorder>(const StadiumBorder()),
);

//
final ButtonStyle elevatedButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(spacing_16)),
  textStyle: MaterialStateProperty.all<TextStyle>(buttonTextStyle),
  shape: MaterialStateProperty.all<StadiumBorder>(const StadiumBorder()),
);

// sign in/sign up with facebook button
final ButtonStyle facebookButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(facebookBlue),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(spacing_16)),
  textStyle: MaterialStateProperty.all<TextStyle>(buttonTextStyle),
  shape: MaterialStateProperty.all<StadiumBorder>(const StadiumBorder()),
);

// sign in/sign up with google button
final ButtonStyle googleButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(googleRed),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(spacing_16)),
  textStyle: MaterialStateProperty.all<TextStyle>(buttonTextStyle),
  shape: MaterialStateProperty.all<StadiumBorder>(const StadiumBorder()),
);

// Floating action button theme
// final FloatingActionButtonThemeData floatingActionButtonLightThemeData =
//     FloatingActionButtonThemeData(
//   backgroundColor: green_10,
//   foregroundColor: white_60,
// );

// forgot password button style
final ButtonStyle linkButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color?>(Colors.blue[600]),
  textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'Montserrat',
  )),
  overlayColor: MaterialStateProperty.all<Color?>(Colors.blue[50]),
);

// Elevation button theme
final ElevatedButtonThemeData elevatedButtonLightThemeData =
    ElevatedButtonThemeData(
  style: elevatedButtonStyle,
);

// light text theme
const TextTheme lightTextTheme = TextTheme(
  headlineLarge: title,
);

// themes
ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: green_10,
    brightness: Brightness.light,
    primary: green_10,
    secondary: green_10,
    tertiary: green_30,
  ),
  brightness: Brightness.light,
  fontFamily: 'Montserrat',
  fontFamilyFallback: const ['Raleway', 'Pacifico'],
  scaffoldBackgroundColor: white_60,
  textTheme: lightTextTheme,
  elevatedButtonTheme: elevatedButtonLightThemeData,
);
