import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class PrefTag extends StatelessWidget {
  final String pref;

  //
  const PrefTag({
    super.key,
    required this.pref,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: spacing_8),
      padding: const EdgeInsets.fromLTRB(
          spacing_16, spacing_8, spacing_16, spacing_8),
      decoration: BoxDecoration(
        color: green_10,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Center(
        child: Text(
          pref,
          style: destinationsTagTextStyle,
        ),
      ),
    );
  }
}
