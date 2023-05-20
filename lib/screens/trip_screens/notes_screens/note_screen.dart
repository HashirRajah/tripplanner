import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/blocs/notes_list_bloc/notes_list_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/notes_app_bar.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/notes_filter_options.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/notes_list.dart';
import 'package:tripplanner/services/firestore_services/group_notes_crud_services.dart';
import 'package:tripplanner/services/firestore_services/personal_notes_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class NotesScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  //
  NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //
    String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    //
    User? user = Provider.of<User?>(context);
    //
    String userId = user!.uid;
    //
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PersonalNotesCRUD(
            tripId: tripId,
            userId: userId,
          ),
        ),
        RepositoryProvider(
          create: (context) => GroupNotesCRUD(
            tripId: tripId,
            userId: userId,
          ),
        ),
      ],
      child: BlocProvider<NotesListBloc>(
        create: (context) => NotesListBloc(
          RepositoryProvider.of<PersonalNotesCRUD>(context),
          RepositoryProvider.of<GroupNotesCRUD>(context),
        )..add(LoadAllPersonalNotes()),
        child: CustomScrollView(
          slivers: <Widget>[
            NotesSliverAppBar(
              controller: controller,
            ),
            const SliverPadding(
              padding:
                  EdgeInsets.fromLTRB(spacing_16, spacing_16, spacing_16, 0.0),
              sliver: SliverToBoxAdapter(
                child: NotesFilterOptions(),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing_24,
                vertical: spacing_8,
              ),
              sliver: NotesList(),
            ),
          ],
        ),
      ),
    );
  }
}
