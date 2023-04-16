import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:lottie/lottie.dart';

class NetworkErrorScreen extends StatelessWidget {
  //
  final String lottieFilePath =
      'assets/lottie_files/no-internet-connection.json';
  final String screenTitle = 'A Network Connection is required to continue';
  //
  const NetworkErrorScreen({super.key});

  //
  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    Orientation screenOrientation = getScreenOrientation(context);
    //
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                      child: Lottie.asset(
                        lottieFilePath,
                        height: getXPercentScreenHeight(50, screenHeight),
                        repeat: false,
                      ),
                    ),
                    addVerticalSpace(spacing_8),
                    Text(
                      screenTitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
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
