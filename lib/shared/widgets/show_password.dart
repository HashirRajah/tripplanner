import 'package:flutter/material.dart';

class TogglePasswordVisibilityIconButton extends StatelessWidget {
  //
  final bool visible;
  final Function toggleVisibility;
  //
  const TogglePasswordVisibilityIconButton(
      {super.key, required this.visible, required this.toggleVisibility});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => toggleVisibility(visible),
      icon: Icon(
        visible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      ),
    );
  }
}
