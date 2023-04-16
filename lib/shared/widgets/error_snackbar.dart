import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

SnackBar errorSnackBar(BuildContext context, String title, String message) {
  return SnackBar(
    duration: const Duration(seconds: 9),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    behavior: SnackBarBehavior.floating,
    content: Container(
      padding: const EdgeInsets.all(spacing_16),
      decoration: BoxDecoration(
        color: errorColor,
        borderRadius: BorderRadius.circular(spacing_16),
      ),
      child: Column(
        children: [
          Text(
            '$title!',
            style: errorTitleTextStyle,
            textAlign: TextAlign.center,
          ),
          addVerticalSpace(spacing_8),
          Text(
            message,
            style: errorMessageTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
