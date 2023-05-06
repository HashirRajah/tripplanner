import 'package:flutter/material.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/destinations_tags.dart';

class DestinationsList extends StatelessWidget {
  final List<DestinationModel> destinations;
  final Function remove;
  const DestinationsList({
    super.key,
    required this.destinations,
    required this.remove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: spacing_40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return DestinationTag(
            destination: destinations[index].description,
            flagUrl: destinations[index].countryCode != 'NONE'
                ? destinations[index].getFlagUrl()
                : 'NONE',
            position: index,
            removeDestination: remove,
          );
        },
        itemCount: destinations.length,
      ),
    );
  }
}
