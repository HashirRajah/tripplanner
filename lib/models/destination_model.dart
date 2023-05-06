import 'package:tripplanner/services/country_flag_services.dart';

class DestinationModel {
  final String description;
  final String countryCode;
  //
  DestinationModel({
    required this.description,
    required this.countryCode,
  });
  //
  String getFlagUrl() {
    final CountryFlagService countryFlagService =
        CountryFlagService(country: countryCode);

    return countryFlagService.getUrl(32);
  }

  //
  Map<String, dynamic> getDestinationMap() {
    return {
      'description': description,
      'country_code': countryCode,
    };
  }
}
