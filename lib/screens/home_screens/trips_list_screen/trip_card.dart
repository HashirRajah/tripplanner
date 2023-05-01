import 'package:flutter/material.dart';
import 'package:tripplanner/models/trip_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TripCard extends StatelessWidget {
  //
  final TripModel trip;
  //
  const TripCard({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  trip.title,
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
                      '${trip.startDate} - ${trip.endDate}',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
        )
      ],
    );
  }
}
