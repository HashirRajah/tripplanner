import 'package:flutter/material.dart';
import 'package:tripplanner/models/find_card_model.dart';
import 'package:tripplanner/screens/find_screens/find_card.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/plan_section/discover_activities_card.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/plan_section/travel_info_card.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class PlanSection extends StatefulWidget {
  const PlanSection({super.key});

  @override
  State<PlanSection> createState() => _PlanSectionState();
}

class _PlanSectionState extends State<PlanSection> {
  final String title = 'Plan';
  //
  final List<FindCardModel> sections = [
    FindCardModel(
      title: 'Flights',
      svgFilePath: 'assets/svgs/flights.svg',
      cardColor: flightsCardColor,
      buttonColor: paletteOrange,
      navigationRoute: Center(),
    ),
    FindCardModel(
      title: 'Hotels',
      svgFilePath: 'assets/svgs/hotels.svg',
      cardColor: hotelsCardColor,
      buttonColor: green_10,
      navigationRoute: Center(),
    ),
    FindCardModel(
      title: 'Car Rentals',
      svgFilePath: 'assets/svgs/car_rental.svg',
      cardColor: carRentalsCardColor,
      buttonColor: alternateGreen,
      navigationRoute: Center(),
    ),
    FindCardModel(
      title: 'Airport Transfers',
      svgFilePath: 'assets/svgs/airport_transfers.svg',
      cardColor: airportTransfersCardColor,
      buttonColor: errorColor,
      navigationRoute: Center(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(spacing_16),
      margin: const EdgeInsets.only(bottom: spacing_16),
      decoration: BoxDecoration(
        color: docTileColor,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: [
          // title
          Text(
            'Investigate',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: green_10, fontWeight: FontWeight.bold),
          ),
          addVerticalSpace(spacing_16),
          const TravelInfoCard(),
          addVerticalSpace(spacing_16),
          Text(
            'Plan',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: green_10, fontWeight: FontWeight.bold),
          ),
          addVerticalSpace(spacing_16),
          const DiscoverActivitiesCard(),
          addVerticalSpace(spacing_16),

          FindCard(
            findCardModel: sections[0],
          ),
          FindCard(
            findCardModel: sections[1],
          ),
          FindCard(
            findCardModel: sections[2],
          ),
          FindCard(
            findCardModel: sections[3],
          ),
        ],
      ),
    );
  }
}
