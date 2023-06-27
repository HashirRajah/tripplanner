import 'package:flutter/material.dart';
import 'package:tripplanner/models/country_model.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/services/country_flag_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class CountrySuggestionTile extends StatelessWidget {
  final CountryModel country;
  final Function onTap;
  final String fallBackImagePath = 'assets/images/default_images/flag.png';
  //
  const CountrySuggestionTile({
    super.key,
    required this.country,
    required this.onTap,
  });
  //
  Widget getImage() {
    try {
      if (country.code == 'NONE') {
        return const Icon(Icons.flag);
      } else {
        return Image.network(
          CountryFlagService(country: country.code).getUrl(64),
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.flag);
          },
        );
      }
    } catch (e) {
      return const Icon(Icons.flag);
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: spacing_32,
        child: getImage(),
      ),
      title: Text(country.name),
      onTap: () => onTap(context, country),
    );
  }
}
