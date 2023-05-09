import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/note_card.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/notes_app_bar.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/notes_filter_options.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const NotesSliverAppBar(),
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(spacing_16, spacing_16, spacing_16, 0.0),
          sliver: SliverToBoxAdapter(
            child: NotesFilterOptions(),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: spacing_24,
            vertical: spacing_8,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const NoteCard(),
              childCount: 20,
            ),
          ),
        ),
      ],
    );
  }
}
