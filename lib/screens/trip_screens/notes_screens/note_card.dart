import 'package:flutter/material.dart';
import 'package:tripplanner/models/trip_card_model.dart';
import 'package:tripplanner/models/trip_model.dart';
import 'package:tripplanner/screens/home_screens/trips_list_screen/trip_expanded_options.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/edit_note_button.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/note_star_button.dart';
import 'package:tripplanner/screens/trip_screens/trip_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class NoteCard extends StatefulWidget {
  //
  //final NoteCardModel trip;
  //
  const NoteCard({
    super.key,
    //required this.trip,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  //
  bool displayExpandedOptions = false;
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
    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      highlightColor: searchBarColor,
      splashColor: docTileColor,
      // onTap: () {
      //   //
      //   if (displayExpandedOptions) {
      //     hideOptions();
      //   } else {
      //     // Navigator.push(
      //     //   context,
      //     //   MaterialPageRoute(
      //     //     builder: (context) => TripScreen(
      //     //       tripId: widget.trip.id,
      //     //     ),
      //     //   ),
      //     // );
      //   }
      // },
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
                      '012345678901234567890', //widget.trip.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    addVerticalSpace(spacing_16),
                    Text(
                      'note blah blah', //widget.trip.getDateFormatted(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              right: spacing_16,
              bottom: spacing_16,
              child: EditNoteButton(),
            ),
            const Positioned(
              right: spacing_16,
              top: spacing_16,
              child: NoteStarButton(),
            ),
          ],
        ),
      ),
    );
  }
}