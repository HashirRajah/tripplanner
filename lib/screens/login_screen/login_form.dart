import 'package:flutter/material.dart';
import 'package:tripplanner/screens/sign_up_screen/sign_up_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/link_button.dart';
import 'package:tripplanner/shared/widgets/or_divider.dart';
import 'package:tripplanner/shared/widgets/question_action.dart';
import 'package:tripplanner/shared/widgets/show_password.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (builder) => const SignUpScreen()));
  }

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //
  String email = '';
  String password = '';
  bool showPassword = false;
  //
  void _togglePasswordVisibility(bool visibility) {
    setState(() {
      showPassword = !visibility;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: email,
            onChanged: (value) => setState(() => email = value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email_outlined),
              hintText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          addVerticalSpace(spacing_24),
          TextFormField(
            initialValue: password,
            onChanged: (value) => setState(() => password = value),
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
          addVerticalSpace(spacing_8),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () {},
              child: const Text('Sign In'),
            ),
          ),
          addVerticalSpace(spacing_8),
          OrDivider(),
          addVerticalSpace(spacing_8),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(MdiIcons.google),
              label: const Text('Sign In with Google'),
              style: googleButtonStyle,
            ),
          ),
          addVerticalSpace(spacing_8),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.facebook),
              label: const Text('Sign In with Facebook'),
              style: facebookButtonStyle,
            ),
          ),
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
