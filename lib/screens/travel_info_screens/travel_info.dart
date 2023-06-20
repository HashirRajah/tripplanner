import 'package:flutter/material.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/screens/travel_info_screens/country_info_section.dart';
import 'package:tripplanner/screens/travel_info_screens/embassy_section.dart';
import 'package:tripplanner/screens/travel_info_screens/visa_info_section.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TravelInfo extends StatelessWidget {
  //
  final DestinationModel destination;
  //
  const TravelInfo({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(spacing_24),
      child: Column(
        children: <Widget>[
          VisaInfoSection(countryName: destination.countryName),
          addVerticalSpace(spacing_24),
          EmbassySection(
            country: destination.countryCode,
          ),
          addVerticalSpace(spacing_24),
          CountryInfoSection(
            countryCode: destination.countryCode,
          ),
        ],
      ),
    );
  }
}
