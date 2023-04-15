import 'package:flutter/material.dart';
import 'package:tripplanner/screens/sign_up_screen/sign_up_screen.dart';
import 'package:tripplanner/services/auth_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/facebook_sign_in.dart';
import 'package:tripplanner/shared/widgets/google_sign_in.dart';
import 'package:tripplanner/shared/widgets/link_button.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/shared/widgets/or_divider.dart';
import 'package:tripplanner/shared/widgets/question_action.dart';
import 'package:tripplanner/shared/widgets/show_password.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class LoginForm extends StatefulWidget {
  //
  final String title;
  //
  const LoginForm({super.key, required this.title});

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _emailFormFieldKey = GlobalKey<FormFieldState>();
  final _passwordFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  //
  final ValidationService validationService = ValidationService();
  //
  String email = '';
  String password = '';
  bool showPassword = false;
  //
  final AuthService _auth = AuthService();
  bool processing = false;
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
    _emailFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(_emailFormFieldKey, _emailFocusNode));
    _passwordFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _passwordFormFieldKey, _passwordFocusNode));
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
    _passwordFocusNode.dispose();
    controller.dispose();
  }

  //
  void _togglePasswordVisibility(bool visibility) {
    setState(() {
      showPassword = !visibility;
    });
  }

  //
  Future _signIn(BuildContext context) async {
    // validate form
    final bool validForm = _formkey.currentState!.validate();
    //
    if (validForm) {
      setState(() => processing = true);
      //
      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
      //
      setState(() => processing = false);
      //
      if (result != null) {
        String errorTitle = 'Sign In Failed';
        String errorMessage = 'Invalid Credentials';
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
            key: _passwordFormFieldKey,
            initialValue: password,
            onChanged: (value) => setState(() => password = value.trim()),
            validator: (value) =>
                validationService.validateEmptyPassword(password),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: TogglePasswordVisibilityIconButton(
                visible: showPassword,
                toggleVisibility: _togglePasswordVisibility,
              ),
              hintText: 'Password',
            ),
            obscureText: !showPassword,
          ),
          addVerticalSpace(spacing_16),
          const ForgotPasswordButton(text: 'Forgot Password?'),
          addVerticalSpace(spacing_8),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () async => _signIn(context),
              child: ButtonChildProcessing(
                processing: processing,
                title: widget.title,
              ),
            ),
          ),
          addVerticalSpace(spacing_8),
          OrDivider(),
          addVerticalSpace(spacing_8),
          const GoogleSignInButton(text: 'In'),
          addVerticalSpace(spacing_8),
          const FacebookSignIn(text: 'In'),
          addVerticalSpace(spacing_8),
          QuestionAction(
            question: 'New to Tripplanner?',
            action: 'Sign Up',
            actionNavigation: widget.navigateToSignUpScreen,
          ),
        ],
      ),
    );
  }
}
