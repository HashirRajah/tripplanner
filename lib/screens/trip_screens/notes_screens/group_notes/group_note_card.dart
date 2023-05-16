import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/group_note_model.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/edit_note_button.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/note_star_button.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/view_button.dart';
import 'package:tripplanner/services/firestore_services/group_notes_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class GroupNoteCard extends StatefulWidget {
  //
  final GroupNoteModel note;
  //
  const GroupNoteCard({
    super.key,
    required this.note,
  });

  @override
  State<GroupNoteCard> createState() => _GroupNoteCardState();
}

class _GroupNoteCardState extends State<GroupNoteCard> {
  //
  final String error = 'Unexpected Error';
  final String message = 'Could not mark / un-mark note as important';
  bool displayExpandedOptions = false;
  late final GroupNotesCRUD groupNotesCRUD;
  late GroupNoteModel realTimeNote;
  late final String userId;
  //
  @override
  void initState() {
    super.initState();
    //
    realTimeNote = widget.note;
    //
    String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    groupNotesCRUD = GroupNotesCRUD(
      tripId: tripId,
      userId: userId,
      noteId: realTimeNote.noteId,
    );
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  void _updateNote(GroupNoteModel note) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        realTimeNote = note;
      });
    });
  }

  //
  Future<void> starUnstarNote() async {
    dynamic result = await groupNotesCRUD
        .starUnstarNote(!realTimeNote.staredBy.contains(userId));
    //
    if (result != null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar(context, error, message));
      }
    }
  }

  //
  void _displayOptions() {
    setState(() {
      displayExpandedOptions = true;
    });
  }

  //
  void hideOptions() {
    setState(() {
      displayExpandedOptions = false;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return StreamBuilder<GroupNoteModel?>(
        stream: groupNotesCRUD.noteStream,
        builder: (context, snapshot) {
          //
          if (snapshot.hasData) {
            _updateNote(snapshot.data!);
          }
          //
          return InkWell(
            borderRadius: BorderRadius.circular(15.0),
            highlightColor: searchBarColor,
            splashColor: docTileColor,
            onTap: () {
              //
              if (displayExpandedOptions) {
                hideOptions();
              }
            },
            onLongPress: () => _displayOptions(),
            child: Container(
              margin: const EdgeInsets.only(
                bottom: spacing_8,
              ),
              child: Stack(
                children: [
                  Card(
                    color: tripCardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 3.0,
                    child: Container(
                      padding: const EdgeInsets.all(spacing_16),
                      //height: spacing_112,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            realTimeNote.title, //widget.trip.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          addVerticalSpace(spacing_16),
                          Text(
                            realTimeNote
                                .getModifiedAtFormatted(), //widget.trip.getDateFormatted(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: spacing_16,
                    bottom: spacing_16,
                    child: userId == realTimeNote.owner
                        ? const EditNoteButton()
                        : const ViewNoteButton(),
                  ),
                  Positioned(
                    right: spacing_16,
                    top: spacing_16,
                    child: NoteStarButton(
                      important: realTimeNote.staredBy.contains(userId),
                      action: starUnstarNote,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
