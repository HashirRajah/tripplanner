import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/notes_app_bar.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const NotesSliverAppBar(),
      ],
    );
  }
}
