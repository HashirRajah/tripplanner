import 'package:flutter/material.dart';
import 'package:tripplanner/screens/sign_up_screen/sign_up_screen.dart';
import 'package:tripplanner/services/auth_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ResetPasswordForm extends StatefulWidget {
  //
  final String title;
  //
  const ResetPasswordForm({super.key, required this.title});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm>
    with SingleTickerProviderStateMixin {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _emailFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _emailFocusNode = FocusNode();
  //
  final ValidationService validationService = ValidationService();
  //
  String email = '';
  //
  final AuthService _auth = AuthService();
  bool processing = false;
  bool emailSent = false;
  //
  final String successMessage = 'Email sent for password reset';
  final String successLottieFilePath = 'assets/lottie_files/sent.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
    //
    _emailFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(_emailFormFieldKey, _emailFocusNode));

    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });
  }

  //
  @override
  void dispose() {
    //
    super.dispose();
    // dispose focus nodes
    _emailFocusNode.dispose();
    controller.dispose();
  }

  //
  Future _sendPasswordResetEmail(BuildContext context) async {
    // validate form
    final bool validForm = _formkey.currentState!.validate();
    //
    if (validForm) {
      setState(() => processing = true);
      //
      dynamic result = await _auth.resetPassword(email);
      //
      setState(() => processing = false);
      //
      if (result == null) {
        //
        setState(() => emailSent = true);
        //
        if (context.mounted) {
          messageDialog(context, successMessage, successLottieFilePath,
              controller, false);
        }
      } else if (result != null) {
        //
        String errorTitle = 'Error';
        String errorMessage = '';
        //
        switch (result) {
          case 'user-not-found':
            {
              errorMessage = 'No account found with email provided';
            }
            break;
        }
        //
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
        }
      }
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            key: _emailFormFieldKey,
            initialValue: email,
            onChanged: (value) => setState(() => email = value),
            validator: (value) => validationService.validateEmail(email),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email_outlined),
              hintText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
            focusNode: _emailFocusNode,
          ),
          addVerticalSpace(spacing_24),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: emailSent
                  ? null
                  : () async => _sendPasswordResetEmail(context),
              child: ButtonChildProcessing(
                processing: processing,
                title: widget.title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
