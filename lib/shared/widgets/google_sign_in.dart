import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/services/auth_services.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';

class GoogleSignInButton extends StatefulWidget {
  final String text;

  const GoogleSignInButton({super.key, required this.text});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton>
    with SingleTickerProviderStateMixin {
  //
  final AuthService _authService = AuthService();
  final String successMessage = 'Signed In';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  bool processing = false;
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

  @override
  void dispose() {
    //
    super.dispose();
    //
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonWrapper(
      childWidget: ElevatedButton.icon(
        onPressed: () async {
          //
          setState(() => processing = true);
          //
          dynamic result = await _authService.signInWithGoogle();
          //
          setState(() => processing = false);
          // if user credential is returned
          if (result != null) {
            if (context.mounted) {
              //
              messageDialog(context, successMessage, successLottieFilePath,
                  controller, false);
            }
          }
        },
        icon: const Icon(MdiIcons.google),
        label: ButtonChildProcessing(
          processing: processing,
          title: 'Sign ${widget.text} with Google',
        ),
        style: googleButtonStyle,
      ),
    );
  }
}
