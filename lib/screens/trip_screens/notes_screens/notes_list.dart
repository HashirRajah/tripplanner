import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/business_logic/blocs/notes_list_bloc/notes_list_bloc.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/group_notes/group_notes_list.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/personal_notes/personal_notes_list.dart';
import 'package:tripplanner/services/firestore_services/group_notes_crud_services.dart';
import 'package:tripplanner/services/firestore_services/personal_notes_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/loading_sliver_list.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class NotesList extends StatelessWidget {
  final String svgFilePath = 'assets/svgs/error.svg';

  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return BlocBuilder<NotesListBloc, NotesListState>(
      builder: (context, state) {
        //
        if (state is LoadingNotesList) {
          return const LoadingSliverList();
        }
        // personal notes
        if (state is PersonalNotesListLoaded) {
          return StreamBuilder(
            stream: RepositoryProvider.of<PersonalNotesCRUD>(context)
                .personalNotesStream,
            builder: (context, snapshot) {
              //
              return PersonalNotesList(notes: state.notes);
            },
          );
        }
        //
        if (state is GroupNotesListLoaded) {
          return StreamBuilder(
            stream:
                RepositoryProvider.of<GroupNotesCRUD>(context).groupNotesStream,
            builder: (context, snapshot) {
              //
              return GroupNotesList(notes: state.notes);
            },
          );
        }
        //
        return SliverToBoxAdapter(
          child: Center(
            child: Column(
              children: <Widget>[
                SvgPicture.asset(
                  svgFilePath,
                  height: getXPercentScreenHeight(30, screenHeight),
                ),
                Text(
                  'An error ocurred!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: green_10,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                addVerticalSpace(spacing_16),
                CircleAvatar(
                  backgroundColor: green_10,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.replay_outlined),
                    color: white_60,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
