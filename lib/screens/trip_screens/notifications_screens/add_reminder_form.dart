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

class AddReminderForm extends StatefulWidget {
  //
  final String title;
  //
  const AddReminderForm({super.key, required this.title});

  @override
  State<AddReminderForm> createState() => _AddReminderFormState();
}

class _AddReminderFormState extends State<AddReminderForm>
    with SingleTickerProviderStateMixin {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _memoFormFieldKey = GlobalKey<FormFieldState>();
  final _passwordFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _memoFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  //
  final ValidationService validationService = ValidationService();
  //
  String memo = '';
  //
  bool processing = false;
  //
  final String successMessage = 'Reminder added';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
    //
    _memoFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(_memoFormFieldKey, _memoFocusNode));
    _passwordFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _passwordFormFieldKey, _passwordFocusNode));
    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.popUntil(
          context,
          (route) => route.settings.name == '/notifications',
        );
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
    _memoFocusNode.dispose();
    _passwordFocusNode.dispose();
    controller.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            key: _memoFormFieldKey,
            initialValue: memo,
            onChanged: (value) => setState(() => memo = value),
            onEditingComplete: () => _memoFocusNode.unfocus(),
            validator: (value) => validationService.validateEmail(memo),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.text_fields_outlined),
              hintText: 'Memo',
            ),
            focusNode: _memoFocusNode,
          ),
          addVerticalSpace(spacing_24),
          addVerticalSpace(spacing_8),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () async {},
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
