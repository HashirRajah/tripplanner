import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class NoteStarButton extends StatelessWidget {
  final bool important;
  const NoteStarButton({super.key, required this.important});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: Colors.amber[200],
      highlightColor: Colors.amber[300],
      onTap: () {},
      child: Icon(
        Icons.star_border_outlined,
        size: Theme.of(context).textTheme.headlineSmall?.fontSize,
        color: green_10,
      ),
    );
  }
}
