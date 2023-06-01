import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class DropdownWrapper extends StatelessWidget {
  final Widget child;
  //
  const DropdownWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: spacing_24,
        vertical: 0.0,
      ),
      decoration: BoxDecoration(
        color: searchBarColor,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(),
      ),
      child: child,
    );
  }
}
