import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:tripplanner/models/place_card_model.dart';
import 'package:tripplanner/shared/constants/api_keys.dart';

class PlaceDetailsAPI {
  // get destinations suggestions
  final String apiKey = gMapsWebApiKey;
  final String authority = 'maps.googleapis.com';
  //

  Future<PlaceCardModel?> getContactDetails(
    String placeId,
  ) async {
    //
    const String unencodedpath = 'maps/api/place/details/json';
    //
    Map<String, dynamic> queryParams = {
      'place_id': placeId,
      'fields': 'name,international_phone_number',
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
      PlaceCardModel? placeDetails;
      //
      if (data['status'] == 'OK') {
        placeDetails = PlaceCardModel(
          data['result']['name'],
          data['result']['international_phone_number'],
        );
      }
      //
      return placeDetails;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //
  Future<LatLng?> getCoordinates(
    String placeId,
  ) async {
    //
    const String unencodedpath = 'maps/api/place/details/json';
    //
    Map<String, dynamic> queryParams = {
      'place_id': placeId,
      'fields': 'geometry',
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
      LatLng? coord;
      //
      if (data['status'] == 'OK') {
        coord = LatLng(
          data['result']['geometry']['location']['lat'],
          data['result']['geometry']['location']['lng'],
        );
      }
      //
      return coord;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
