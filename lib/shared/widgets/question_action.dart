import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class QuestionAction extends StatelessWidget {
  //
  final String question;
  final String action;
  final Function actionNavigation;
  //
  const QuestionAction(
      {super.key,
      required this.question,
      required this.action,
      required this.actionNavigation});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          question,
          style: questionActionTextStyle,
        ),
        TextButton(
          onPressed: () => actionNavigation(context),
          style: linkButtonStyle,
          child: Text(action),
        ),
      ],
    );
  }
}
