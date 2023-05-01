import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tripplanner/models/destination_suggestions_model.dart';
import 'package:tripplanner/shared/constants/api_keys.dart';

class PlacesAPI {
  // get destinations suggestions
  final String apiKey = gMapsWebApiKey;
  final String authority = 'maps.googleapis.com';
  //
  Future<List<DestinationSuggestionModel>?> destinationsSuggestions(
      String query) async {
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
    //make request
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //debugPrint(data.toString());
      //
      if (data['status'] == 'OK') {
        List<DestinationSuggestionModel> predictions = [];
        //
        for (Map prediction in data['predictions']) {
          // get country code
          String? countryCode = await getCountryCode(prediction['place_id']);
          //
          predictions.add(DestinationSuggestionModel(
            description: prediction['description'],
            countryCode: countryCode ?? 'NONE',
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
  Future<String?> getCountryCode(String placeId) async {
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
        //
        for (Map addressComponent in data['result']['address_components']) {
          if (addressComponent['types'].contains('country')) {
            countryCode = addressComponent['short_name'];
            break;
          }
        }
        //
        return countryCode;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
