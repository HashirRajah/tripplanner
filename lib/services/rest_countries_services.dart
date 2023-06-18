import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:tripplanner/models/country_info_model.dart';
import 'package:tripplanner/models/currency_model.dart';
import 'package:tripplanner/models/language_model.dart';

class RestCountriesService {
  final String authority = 'restcountries.com';
  //
  Future<CountryInfoModel?> getCountryInfo(String countryCode) async {
    final String unencodedpath = 'v3.1/alpha/$countryCode';
    //
    Uri url = Uri.https(
      authority,
      unencodedpath,
    );
    //
    try {
      Response response = await get(url);
      List<dynamic> data = jsonDecode(response.body);
      // languages
      List<LanguageModel> languages = [];
      data[0]['languages'].forEach((key, value) {
        LanguageModel lang = LanguageModel(lang: value, langCode: key);
        //
        languages.add(lang);
      });
      // currencies
      List<CurrencyModel> currencies = [];
      data[0]['currencies'].forEach((key, value) {
        CurrencyModel currency = CurrencyModel(
          name: value['name'],
          code: key,
        );
        currencies.add(currency);
      });
      // capital info
      List<String> capitals = [];
      data[0]['capital'].forEach((value) {
        capitals.add(value);
      });
      // capital info
      List<LatLng> capitalsInfo = [];
      //
      CountryInfoModel countryInfo = CountryInfoModel(
        name: data[0]['name']['common'],
        officialName: data[0]['name']['official'],
        capital: capitals,
        independent: data[0]['independent'],
        currencies: currencies,
        languages: languages,
        capitalLatLng: capitalsInfo,
        population: data[0]['population'],
      );
      //
      return countryInfo;
    } catch (e) {
      return null;
    }
  }

  //
  Future<String?> getCountryName(String countryCode) async {
    final String unencodedpath = 'v3.1/alpha/$countryCode';
    //
    Uri url = Uri.https(
      authority,
      unencodedpath,
    );
    //
    try {
      Response response = await get(url);
      List<dynamic> data = jsonDecode(response.body);
      //
      return data[0]['name']['common'];
    } catch (e) {
      return null;
    }
  }
}
