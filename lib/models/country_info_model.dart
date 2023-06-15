import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripplanner/models/currency_model.dart';
import 'package:tripplanner/models/language_model.dart';

class CountryInfoModel {
  final String name;
  final String officialName;
  final List<String> capital;
  final bool independent;
  final List<CurrencyModel> currencies;
  final List<LanguageModel> languages;
  final List<LatLng> capitalLatLng;
  final int population;
  //
  CountryInfoModel({
    required this.name,
    required this.officialName,
    required this.capital,
    required this.independent,
    required this.currencies,
    required this.languages,
    required this.capitalLatLng,
    required this.population,
  });
}
