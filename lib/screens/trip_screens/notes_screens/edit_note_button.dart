import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/edit_note_screen/edit_note_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class EditNoteButton extends StatelessWidget {
  const EditNoteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: alternateGreen,
      highlightColor: green_30,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditNoteScreen(),
          ),
        );
      },
      child: Icon(
        Icons.mode_edit_outline,
        size: Theme.of(context).textTheme.headlineSmall?.fontSize,
        color: green_10,
      ),
    );
  }
}
