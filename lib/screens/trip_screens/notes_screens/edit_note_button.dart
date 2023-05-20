import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/blocs/notes_list_bloc/notes_list_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/personal_note_model.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/edit_note_screen/edit_note_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class EditNoteButton extends StatelessWidget {
  final PersonalNoteModel note;
  const EditNoteButton({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: alternateGreen,
      highlightColor: green_30,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (newContext) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: BlocProvider.of<TripIdCubit>(context),
                ),
                BlocProvider.value(
                  value: BlocProvider.of<NotesListBloc>(context),
                ),
              ],
              child: EditNoteScreen(
                note: note,
              ),
            ),
          ),
        );
      },
      child: Icon(
        Icons.mode_edit_outline,
        size: Theme.of(context).textTheme.headlineSmall?.fontSize,
        color: green_10,
      ),
    );
  }
}
