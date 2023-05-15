import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/blocs/notes_list_bloc/notes_list_bloc.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/add_notes_screen/add_note_screen.dart';

class AddNotesButton extends StatelessWidget {
  const AddNotesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (newContext) => const AddNoteScreen(),
          ),
        );
      },
      child: const Icon(Icons.note_add_outlined),
    );
  }
}
