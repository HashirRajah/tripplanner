import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/services/launcher_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EmailVerificationScreen extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/mail.svg';
  final String screenTitle = 'Email Verification';
  final String message =
      'A verification email has been sent to you. Please verify you email to continue.';

  final LauncherServices launcherService = LauncherServices();
  //
  EmailVerificationScreen({super.key});
  //
  Widget _showOpenMailButton(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return ElevatedButtonWrapper(
        childWidget: ElevatedButton.icon(
          onPressed: () async => launcherService.launchEmailApp(),
          icon: const Icon(Icons.launch_outlined),
          label: const Text('Open Email'),
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.tertiary)),
        ),
      );
    }
    //
    return addVerticalSpace(0.0);
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
                    height: getXPercentScreenHeight(25, screenHeight),
                  ),
                  addVerticalSpace(spacing_8),
                  Text(
                    screenTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  addVerticalSpace(spacing_8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  addVerticalSpace(spacing_24),
                  ElevatedButtonWrapper(
                    childWidget: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.send_outlined),
                      label: const Text('Resend Email'),
                    ),
                  ),
                  addVerticalSpace(spacing_8),
                  _showOpenMailButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
