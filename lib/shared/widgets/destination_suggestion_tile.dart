import 'package:flutter/material.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class DestinationSuggestionTile extends StatelessWidget {
  final DestinationModel destination;
  final Function onTap;
  final String fallBackImagePath = 'assets/images/default_images/flag.png';
  //
  const DestinationSuggestionTile({
    super.key,
    required this.destination,
    required this.onTap,
  });
  //
  Widget getImage() {
    try {
      if (destination.countryCode == 'NONE') {
        return const Icon(Icons.flag);
      } else {
        return Image.network(
          destination.getFlagUrl(),
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.flag);
          },
        );
      }
    } catch (e) {
      return const Icon(Icons.flag);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: spacing_32,
        child: getImage(),
      ),
      title: Text(destination.description),
      onTap: () => onTap(context, destination),
    );
  }
}
