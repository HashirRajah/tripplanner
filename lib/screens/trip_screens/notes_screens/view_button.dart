import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class ViewNoteButton extends StatelessWidget {
  const ViewNoteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: alternateGreen,
      highlightColor: green_30,
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const EditNoteScreen(),
        //   ),
        // );
      },
      child: Icon(
        Icons.remove_red_eye_outlined,
        size: Theme.of(context).textTheme.headlineSmall?.fontSize,
        color: green_10,
      ),
    );
  }
}
