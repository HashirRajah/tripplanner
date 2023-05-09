import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class EditNoteButton extends StatelessWidget {
  const EditNoteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: alternateGreen,
      highlightColor: green_30,
      onTap: () {},
      child: Icon(
        Icons.edit_note_outlined,
        size: Theme.of(context).textTheme.headlineSmall?.fontSize,
        color: green_10,
      ),
    );
  }
}
