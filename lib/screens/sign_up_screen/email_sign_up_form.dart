import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/show_password.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EmailSignUpForm extends StatefulWidget {
  const EmailSignUpForm({super.key});

  @override
  State<EmailSignUpForm> createState() => _EmailSignUpFormState();
}

class _EmailSignUpFormState extends State<EmailSignUpForm> {
  //
  String username = '';
  String email = '';
  String password = '';
  String confirmedPassword = '';
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
            initialValue: username,
            onChanged: (value) => setState(() => username = value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              hintText: 'Username',
            ),
            keyboardType: TextInputType.name,
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
          addVerticalSpace(spacing_24),
          TextFormField(
            initialValue: confirmedPassword,
            onChanged: (value) => setState(() => confirmedPassword = value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock_open_outlined),
              hintText: 'Confirm Password',
            ),
            obscureText: true,
          ),
          addVerticalSpace(spacing_24),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () {},
              child: const Text('Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}
