import 'package:flutter/material.dart';
import 'package:tripplanner/models/find_card_model.dart';
import 'package:tripplanner/screens/find_screens/find_card.dart';
import 'package:tripplanner/screens/find_screens/find_screen_app_bar.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class FindScreen extends StatelessWidget {
  FindScreen({super.key});
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

  //
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const FindSliverAppBar(),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: spacing_16,
            vertical: spacing_8,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => FindCard(
                findCardModel: sections[index],
              ),
              childCount: sections.length,
            ),
          ),
        ),
      ],
    );
  }
}
