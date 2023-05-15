import 'package:flutter/material.dart';
import 'package:tripplanner/models/personal_note_model.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/personal_notes/note_card.dart';
import 'package:tripplanner/shared/widgets/empty_sliver_list.dart';

class PersonalNotesList extends StatelessWidget {
  final String svgFilePath = 'assets/svgs/no_notes.svg';
  final String message = 'No notes';
  final List<PersonalNoteModel> notes;
  //
  const PersonalNotesList({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return EmptySliverList(svgFilePath: svgFilePath, message: message);
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return NoteCard(note: notes[index]);
          },
          childCount: notes.length,
        ),
      );
    }
  }
}
