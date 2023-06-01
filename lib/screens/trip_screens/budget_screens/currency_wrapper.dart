import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class CurrencyWrapper extends StatelessWidget {
  final Widget child;
  //
  const CurrencyWrapper({super.key, required this.child});

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Currency :',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, color: green_10),
          ),
          addHorizontalSpace(spacing_16),
          child,
        ],
      ),
    );
  }
}
