import 'package:flutter/material.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/screens/travel_info_screens/travel_info.dart';

class TravelInfoTabs extends StatelessWidget {
  final List<DestinationModel> destinations;
  //
  const TravelInfoTabs({
    super.key,
    required this.destinations,
  });
  //
  List<Widget> getTabs() {
    return destinations
        .map((DestinationModel destination) => TravelInfo(
              destination: destination,
            ))
        .toList();
  }

  //
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: getTabs(),
    );
  }
}
