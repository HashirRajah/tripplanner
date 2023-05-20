import 'package:flutter/material.dart';
import 'package:tripplanner/models/group_note_model.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/group_notes/group_note_card.dart';
import 'package:tripplanner/shared/widgets/empty_sliver_list.dart';

class GroupNotesList extends StatelessWidget {
  final String svgFilePath = 'assets/svgs/no_notes.svg';
  final String message = 'No notes';
  final List<GroupNoteModel> notes;
  //
  const GroupNotesList({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return EmptySliverList(svgFilePath: svgFilePath, message: message);
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return GroupNoteCard(note: notes[index]);
          },
          childCount: notes.length,
        ),
      );
    }
  }
}
