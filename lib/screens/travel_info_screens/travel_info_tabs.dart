import 'package:flutter/material.dart';
import 'package:tripplanner/models/destination_model.dart';

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
        .map((DestinationModel destination) => Center(
              child: Text(destination.description),
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
