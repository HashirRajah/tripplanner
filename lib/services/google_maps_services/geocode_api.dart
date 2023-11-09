import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:tripplanner/models/country_model.dart';
import 'package:tripplanner/shared/constants/api_keys.dart';

class GeocodeAPI {
  // get destinations suggestions
  final String apiKey = gMapsWebApiKey;
  final String authority = 'maps.googleapis.com';
  //

  Future<CountryModel?> getCountryInfo(LatLng location) async {
    //
    const String unencodedpath = 'maps/api/geocode/json';
    //
    Map<String, dynamic> queryParams = {
      'latlng': '${location.latitude}, ${location.longitude}',
      'key': gMapsWebApiKey,
    };
    //
    Uri url = Uri.https(
      authority,
      unencodedpath,
      queryParams,
    );
    //make request
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //debugPrint(data.toString());
      //
      if (response.statusCode == 200) {
        String countryCode = '';
        String countryName = '';
        CountryModel? country;
        //
        for (Map addressComponent in data['results'][0]['address_components']) {
          if (addressComponent['types'].contains('country')) {
            countryCode = addressComponent['short_name'];
            countryName = addressComponent['long_name'];
            //
            country = CountryModel(name: countryName, code: countryCode);
            //
            break;
          }
        }
        //
        return country;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
