import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
const double spacing_72 = 72.0;
const double spacing_80 = 80.0;
const double spacing_88 = 88.0;
const double spacing_96 = 96.0;
const double spacing_104 = 104.0;
const double spacing_112 = 112.0;
const double spacing_120 = 120.0;
const double spacing_128 = 128.0;

// colors
final Color green_10 = colorFromHexCode('#00425A');
final Color green_30 = colorFromHexCode('#1F8A70');
final Color white_60 = colorFromHexCode('#f8f8ff');
final Color alternateGreen = colorFromHexCode('#BFDB38');
final Color paletteOrange = colorFromHexCode('#FC7300');
final Color errorColor = colorFromHexCode('#d0312d');
final Color gold = colorFromHexCode('#FFD384');

//
final Color pdfTileColor = colorFromHexCode('#ff5348');
final Color imageTileColor = colorFromHexCode('#088395');
// provider colors
final Color facebookBlue = colorFromHexCode('#4267B2');
final Color googleRed = colorFromHexCode('#DB4437');

// status bar
SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.light,
);

//
SystemUiOverlayStyle darkOverlayStyle = const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.dark,
);

// text styles
const TextStyle title = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.black,
  letterSpacing: 2.0,
);

//
const TextStyle lightHeadlineMedium = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.black,
  letterSpacing: 1.5,
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

// error text style
final TextStyle errorTitleTextStyle = TextStyle(
  color: white_60,
  fontSize: 16.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
  letterSpacing: 1.5,
);

final TextStyle errorMessageTextStyle = TextStyle(
  color: white_60,
  fontSize: 14.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
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
  headlineMedium: lightHeadlineMedium,
);

// search bar color
final Color searchBarColor = colorFromHexCode('#d5f5ed');

// trip card color
final Color tripCardColor = colorFromHexCode('#fcfefd');

// search border
final InputBorder searchBorder = OutlineInputBorder(
  borderSide: BorderSide(color: searchBarColor),
  borderRadius: BorderRadius.circular(50.0),
);

// search bar text input decoration
final InputDecoration searchBarInputDecoration = InputDecoration(
  filled: true,
  fillColor: searchBarColor,
  border: searchBorder,
  enabledBorder: searchBorder,
  focusedBorder: searchBorder,
  prefixIcon: const Icon(Icons.search_outlined),
  iconColor: white_60,
  prefixIconColor: green_10,
  hintStyle: TextStyle(fontWeight: FontWeight.w600, color: green_10),
  suffixIconColor: green_10,
);

// add trip form input styles
final TextStyle dateTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: errorColor,
);

//
final TextStyle destinationsTagTextStyle = TextStyle(
  color: white_60,
  fontWeight: FontWeight.bold,
);

// doc tiles
final Color docTileColor = colorFromHexCode('#ebfaf6');

// speed dial text style
final TextStyle speedDialTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: green_10,
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
