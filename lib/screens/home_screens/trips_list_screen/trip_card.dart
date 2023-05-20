import 'package:flutter/material.dart';
import 'package:tripplanner/models/trip_card_model.dart';
import 'package:tripplanner/models/trip_model.dart';
import 'package:tripplanner/screens/home_screens/trips_list_screen/trip_expanded_options.dart';
import 'package:tripplanner/screens/trip_screens/trip_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TripCard extends StatefulWidget {
  //
  final TripCardModel trip;
  //
  const TripCard({
    super.key,
    required this.trip,
  });

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
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
      highlightColor: green_10,
      splashColor: searchBarColor,
      onTap: () {
        //
        if (displayExpandedOptions) {
          hideOptions();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TripScreen(
                tripId: widget.trip.id,
              ),
              settings: const RouteSettings(
                name: '/trips',
              ),
            ),
          );
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
                      widget.trip.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    addVerticalSpace(spacing_16),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: green_30,
                        ),
                        addHorizontalSpace(spacing_16),
                        Text(
                          widget.trip.getDateFormatted(),
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: errorColor,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: spacing_16,
              bottom: spacing_16,
              child: Icon(
                Icons.arrow_forward_outlined,
                size: Theme.of(context).textTheme.headlineSmall?.fontSize,
                color: green_10,
              ),
            ),
            displayExpandedOptions
                ? TripsExpandedOptions(
                    id: widget.trip.id,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
