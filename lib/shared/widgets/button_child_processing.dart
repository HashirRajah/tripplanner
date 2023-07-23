import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ButtonChildProcessing extends StatelessWidget {
  final String title;
  final bool processing;
  //
  const ButtonChildProcessing(
      {super.key, required this.processing, required this.title});

  @override
  Widget build(BuildContext context) {
    print(processing);
    if (processing) {
      return SizedBox(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          color: white_60,
          strokeWidth: 2.0,
        ),
      );
    } else {
      return Text(title);
    }
  }
}
