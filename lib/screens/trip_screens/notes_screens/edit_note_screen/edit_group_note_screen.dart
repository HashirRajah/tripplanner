import 'package:flutter/material.dart';
import 'package:tripplanner/models/group_note_model.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/edit_note_screen/edit_group_note_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EditGroupNoteScreen extends StatelessWidget {
  //
  final String screenTitle = 'Edit Note';
  final GroupNoteModel note;
  //
  const EditGroupNoteScreen({super.key, required this.note});

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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(spacing_24),
            child: Center(
              child: EditGroupNoteForm(
                title: 'Save',
                note: note,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
