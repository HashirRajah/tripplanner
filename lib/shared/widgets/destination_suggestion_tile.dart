import 'package:flutter/material.dart';
import 'package:tripplanner/models/destination_suggestions_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class DestinationSuggestionTile extends StatelessWidget {
  final DestinationSuggestionModel destination;
  final Function onTap;
  final String fallBackImagePath = 'assets/images/default_images/flag.png';
  //
  const DestinationSuggestionTile({
    super.key,
    required this.destination,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: spacing_32,
        child: destination.countryCode == 'NONE'
            ? Image.asset(fallBackImagePath)
            : Image.network(destination.getFlagUrl()),
      ),
      title: Text(destination.description),
      onTap: () => onTap(context, destination),
    );
  }
}
