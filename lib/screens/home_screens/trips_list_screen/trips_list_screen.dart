import 'package:flutter/material.dart';
import 'package:tripplanner/models/trip_model.dart';
import 'package:tripplanner/screens/home_screens/trips_list_screen/trip_card.dart';
import 'package:tripplanner/screens/home_screens/trips_list_screen/trips_sliver_app_bar.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/search_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TripsListScreen extends StatelessWidget {
  const TripsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return CustomScrollView(
      slivers: [
        const TripsSliverAppBar(),
        SliverPadding(
          padding: const EdgeInsets.all(spacing_24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return const TripCard(
                  trip: TripModel(
                    id: '200',
                    title: '01234567890123456789123',
                    startDate: '20 Apr',
                    endDate: '30 May 2023',
                  ),
                );
              },
              childCount: 100,
            ),
          ),
        ),
      ],
    );
  }
}
