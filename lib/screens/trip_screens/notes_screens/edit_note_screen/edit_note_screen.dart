import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/edit_note_screen/edit_note_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EditNoteScreen extends StatelessWidget {
  //
  final String screenTitle = 'Edit Note';

  //
  const EditNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
        backgroundColor: docTileColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0.0,
          centerTitle: true,
          title: Text(screenTitle),
          systemOverlayStyle: darkOverlayStyle,
        ),
        body: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(spacing_24),
            child: Center(
              child: EditNoteForm(title: 'Save'),
            ),
          ),
        ),
      ),
    );
  }
}
