import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tripplanner/models/country_model.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/shared/constants/api_keys.dart';

class PlacesAPI {
  // get destinations suggestions
  final String apiKey = gMapsWebApiKey;
  final String authority = 'maps.googleapis.com';
  //
  Future<List<DestinationModel>?> destinationsSuggestions(String query) async {
    //
    const String unencodedpath = 'maps/api/place/autocomplete/json';
    //
    Map<String, dynamic> queryParams = {
      'key': gMapsWebApiKey,
      'input': query,
      'types': '(regions)'
    };
    //
    Uri url = Uri.https(
      authority,
      unencodedpath,
      queryParams,
    );
    //
    if (query.length < 3) {
      return null;
    }
    //make request
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //debugPrint(data.toString());
      //
      if (data['status'] == 'OK') {
        List<DestinationModel> predictions = [];
        //
        for (Map prediction in data['predictions']) {
          // get country code
          List<String>? countryInfoData =
              await getCountryCode(prediction['place_id']);
          //
          predictions.add(DestinationModel(
            description: prediction['description'],
            countryCode: countryInfoData != null ? countryInfoData[0] : 'NONE',
            countryName: countryInfoData != null ? countryInfoData[1] : 'NONE',
          ));
        }
        //
        return predictions;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<CountryModel>?> countrySuggestions(String query) async {
    //
    const String unencodedpath = 'maps/api/place/autocomplete/json';
    //
    Map<String, dynamic> queryParams = {
      'key': gMapsWebApiKey,
      'input': query,
      'types': 'country'
    };
    //
    Uri url = Uri.https(
      authority,
      unencodedpath,
      queryParams,
    );
    //
    if (query.length < 3) {
      return null;
    }
    //make request
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      debugPrint(data.toString());
      //
      if (data['status'] == 'OK') {
        List<CountryModel> predictions = [];
        //
        for (Map prediction in data['predictions']) {
          // get country code
          List<String>? countryInfoData =
              await getCountryCode(prediction['place_id']);
          //
          predictions.add(CountryModel(
            name: prediction['description'],
            code: countryInfoData != null ? countryInfoData[0] : 'NONE',
          ));
        }
        //
        return predictions;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //
  Future<List<String>?> getCountryCode(String placeId) async {
    //
    const String unencodedpath = 'maps/api/place/details/json';
    //
    Map<String, dynamic> queryParams = {
      'key': gMapsWebApiKey,
      'place_id': placeId,
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
      if (data['status'] == 'OK') {
        String countryCode = '';
        String countryName = '';
        //
        for (Map addressComponent in data['result']['address_components']) {
          if (addressComponent['types'].contains('country')) {
            countryCode = addressComponent['short_name'];
            countryName = addressComponent['long_name'];
            break;
          }
        }
        //
        return [countryCode, countryName];
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
  //
}
