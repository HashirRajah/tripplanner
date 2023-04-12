import 'package:flutter/material.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ElevatedButtonWrapper extends StatelessWidget {
  //
  final Widget childWidget;
  //
  const ElevatedButtonWrapper({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    Orientation screenOrientation = getScreenOrientation(context);
    //
    return FractionallySizedBox(
      widthFactor: screenOrientation == Orientation.portrait ? 1.0 : 0.75,
      child: childWidget,
    );
  }
}
