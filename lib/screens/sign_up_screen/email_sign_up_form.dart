import 'package:flutter/material.dart';
import 'package:tripplanner/services/auth_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/shared/widgets/show_password.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EmailSignUpForm extends StatefulWidget {
  final String title;
  //
  const EmailSignUpForm({super.key, required this.title});

  @override
  State<EmailSignUpForm> createState() => _EmailSignUpFormState();
}

class _EmailSignUpFormState extends State<EmailSignUpForm>
    with SingleTickerProviderStateMixin {
  //
  final _formkey = GlobalKey<FormState>();
  final _emailFormFieldKey = GlobalKey<FormFieldState>();
  final _usernameFormFieldKey = GlobalKey<FormFieldState>();
  final _passwordFormFieldKey = GlobalKey<FormFieldState>();
  final _confirmPasswordFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  //
  final ValidationService validationService = ValidationService();
  //
  String username = '';
  String email = '';
  String password = '';
  String confirmedPassword = '';
  bool showPassword = false;
  bool showConfirmedPassword = false;
  //
  final AuthService _auth = AuthService();
  bool processing = false;
  //
  //
  final String successMessage = 'Account Created';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
    // add listeners to focus nodes for textFormField validation
    _emailFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(_emailFormFieldKey, _emailFocusNode));
    //
    _usernameFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _usernameFormFieldKey, _usernameFocusNode));
    //
    _passwordFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _passwordFormFieldKey, _passwordFocusNode));
    //
    _confirmPasswordFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(
            _confirmPasswordFormFieldKey, _confirmPasswordFocusNode));
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
    // dispose focus nodes
    _emailFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    controller.dispose();
  }

  //
  void _togglePasswordVisibility(bool visibility) {
    setState(() {
      showPassword = !visibility;
    });
  }

  void _toggleConfirmPasswordVisibility(bool visibility) {
    setState(() {
      showConfirmedPassword = !visibility;
    });
  }

  //
  Future _signUp() async {
    // validate form
    final bool validForm = _formkey.currentState!.validate();
    //
    if (validForm) {
      //
      setState(() => processing = true);
      //
      dynamic result =
          await _auth.signUpWithEmailAndPassword(email, password, username);
      //
      setState(() => processing = false);
      // check if errors
      if (result != null) {
        String errorTitle = 'Sign Up Failed';
        String errorMessage = '';
        //
        switch (result) {
          case 'weak-password':
            {
              errorMessage = 'Provide a stronger Password';
            }
            break;
          case 'email-already-in-use':
            {
              errorMessage = 'An account already exists for this email';
            }
            break;
        }
        //
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
        }
      } else if (result == null) {
        if (context.mounted) {
          messageDialog(context, successMessage, successLottieFilePath,
              controller, false);
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
            onEditingComplete: () => _emailFocusNode.unfocus(),
            validator: (value) => validationService.validateEmail(email),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email_outlined),
              hintText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
            focusNode: _emailFocusNode,
          ),
          addVerticalSpace(spacing_24),
          TextFormField(
            key: _usernameFormFieldKey,
            initialValue: username,
            onChanged: (value) => setState(() => username = value.trim()),
            onEditingComplete: () => _usernameFocusNode.unfocus(),
            validator: (value) => validationService.validateUsername(username),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              hintText: 'Username',
            ),
            keyboardType: TextInputType.name,
            focusNode: _usernameFocusNode,
          ),
          addVerticalSpace(spacing_24),
          TextFormField(
            key: _passwordFormFieldKey,
            initialValue: password,
            onChanged: (value) => setState(() => password = value),
            onEditingComplete: () => _passwordFocusNode.unfocus(),
            validator: (value) => validationService.validatePassword(password),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: TogglePasswordVisibilityIconButton(
                visible: showPassword,
                toggleVisibility: _togglePasswordVisibility,
              ),
              hintText: 'Password',
            ),
            obscureText: !showPassword,
            focusNode: _passwordFocusNode,
          ),
          addVerticalSpace(spacing_24),
          TextFormField(
            key: _confirmPasswordFormFieldKey,
            initialValue: confirmedPassword,
            onChanged: (value) => setState(() => confirmedPassword = value),
            onEditingComplete: () => _confirmPasswordFocusNode.unfocus(),
            validator: (value) => validationService
                .validatePasswordConfirmation(password, confirmedPassword),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_open_outlined),
              suffixIcon: TogglePasswordVisibilityIconButton(
                visible: showConfirmedPassword,
                toggleVisibility: _toggleConfirmPasswordVisibility,
              ),
              hintText: 'Confirm Password',
            ),
            obscureText: !showConfirmedPassword,
            focusNode: _confirmPasswordFocusNode,
          ),
          addVerticalSpace(spacing_24),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () async => _signUp(),
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
