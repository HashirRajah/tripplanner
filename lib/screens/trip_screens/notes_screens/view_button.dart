import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/view_note_screens/view_group_note_screen.dart';
import 'package:tripplanner/services/firestore_services/group_notes_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class ViewNoteButton extends StatelessWidget {
  final GroupNotesCRUD groupNotesCRUD;
  //
  const ViewNoteButton({super.key, required this.groupNotesCRUD});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: alternateGreen,
      highlightColor: green_30,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewGroupNote(
              groupNotesCRUD: groupNotesCRUD,
            ),
          ),
        );
      },
      child: Icon(
        Icons.remove_red_eye_outlined,
        size: Theme.of(context).textTheme.headlineSmall?.fontSize,
        color: green_10,
      ),
    );
  }
}
