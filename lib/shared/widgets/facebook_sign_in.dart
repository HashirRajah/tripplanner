import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/services/auth_services.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';

class FacebookSignIn extends StatefulWidget {
  final String text;

  const FacebookSignIn({super.key, required this.text});

  @override
  State<FacebookSignIn> createState() => _FacebookSignInState();
}

class _FacebookSignInState extends State<FacebookSignIn>
    with SingleTickerProviderStateMixin {
  //
  final AuthService _authService = AuthService();
  //
  final String successMessage = 'Signed In';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.popUntil(context, (route) => route.isFirst);
        controller.reset();
      }
    });
  }

  //
  @override
  void dispose() {
    //
    super.dispose();
    //
    controller.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return ElevatedButtonWrapper(
      childWidget: ElevatedButton.icon(
        onPressed: () async {
          dynamic result = await _authService.signInWithFacebook();
          // if user credential is returned
          if (result != null) {
            if (context.mounted) {
              //
              messageDialog(context, successMessage, successLottieFilePath,
                  controller, false);
            }
          }
        },
        icon: const Icon(Icons.facebook),
        label: Text('Sign ${widget.text} with Facebook'),
        style: facebookButtonStyle,
      ),
    );
  }
}
