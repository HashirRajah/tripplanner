import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
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
            builder: (newContext) => BlocProvider.value(
              value: BlocProvider.of<TripIdCubit>(context),
              child: const AddNoteScreen(),
            ),
          ),
        );
      },
      child: const Icon(Icons.note_add_outlined),
    );
  }
}
