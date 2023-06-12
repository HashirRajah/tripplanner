import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ErrorRow extends StatelessWidget {
  final String error;
  //
  const ErrorRow({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        addHorizontalSpace(spacing_8),
        Text(
          error,
          style: TextStyle(color: errorColor),
        ),
      ],
    );
  }
}
