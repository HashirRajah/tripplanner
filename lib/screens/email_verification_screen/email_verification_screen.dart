import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/services/auth_services.dart';
import 'package:tripplanner/services/launcher_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String svgFilePath = 'assets/svgs/mail.svg';
  final String screenTitle = 'Email Verification';
  final String message =
      'A verification email has been sent to you. Please verify you email to continue.';
  //
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  //
  final AuthService _auth = AuthService();
  final LauncherServices launcherService = LauncherServices();
  bool canSendMail = true;
  bool userVerified = false;
  //
  late Timer timer;
  //
  @override
  void initState() {
    super.initState();
    // send verification email
    sendVerificationEmail();
    //
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _auth.reloadUser();
    });
  }

  @override
  void dispose() {
    //
    super.dispose();
    //
    timer.cancel();
  }

  //
  Future<void> sendVerificationEmail() async {
    //
    bool isVerified = await _auth.isUserVerified();
    //
    if (mounted) {
      setState(() => userVerified = isVerified);
    }
    //
    if (userVerified) {
      if (mounted) {
        setState(() => canSendMail = false);
      }
      return;
    }
    //
    if (canSendMail) {
      await _auth.verifyEmail();
      //
      if (mounted) {
        setState(() => canSendMail = false);
      }
      //
      await Future.delayed(const Duration(seconds: 10));
      //
      if (mounted && !userVerified) {
        setState(() => canSendMail = true);
      }
    }
  }

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
                    Theme.of(context).colorScheme.tertiary),
              ),
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
                    widget.svgFilePath,
                    height: getXPercentScreenHeight(25, screenHeight),
                  ),
                  addVerticalSpace(spacing_8),
                  Text(
                    widget.screenTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  addVerticalSpace(spacing_8),
                  Text(
                    widget.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  addVerticalSpace(spacing_24),
                  ElevatedButtonWrapper(
                    childWidget: ElevatedButton.icon(
                      onPressed: !canSendMail
                          ? null
                          : () async => sendVerificationEmail(),
                      icon: const Icon(Icons.send_outlined),
                      label: const Text('Resend Email'),
                    ),
                  ),
                  addVerticalSpace(spacing_8),
                  _showOpenMailButton(context),
                  addVerticalSpace(spacing_8),
                  ElevatedButtonWrapper(
                    childWidget: ElevatedButton.icon(
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(errorColor)),
                      onPressed: () async => _auth.signOut(),
                      icon: const Icon(Icons.cancel_outlined),
                      label: const Text('Cancel'),
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
