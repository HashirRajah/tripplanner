import 'package:tripplanner/services/country_flag_services.dart';

class DestinationSuggestionModel {
  final String description;
  final String countryCode;
  //
  DestinationSuggestionModel({
    required this.description,
    required this.countryCode,
  });
  //
  String getFlagUrl() {
    final CountryFlagService countryFlagService =
        CountryFlagService(country: countryCode);

    return countryFlagService.getUrl(32);
  }
}
