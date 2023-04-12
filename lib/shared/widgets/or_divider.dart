import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class OrDivider extends StatelessWidget {
  //
  final Color color = Colors.grey[350] ?? Colors.grey;

  OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Divider(
          thickness: 1.5,
          color: color,
        ),
        Container(
          padding: const EdgeInsets.all(spacing_8),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Text(
            'OR',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
