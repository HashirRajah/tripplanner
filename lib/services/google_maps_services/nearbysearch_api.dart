import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:tripplanner/models/country_model.dart';
import 'package:tripplanner/models/place_marker_model.dart';
import 'package:tripplanner/shared/constants/api_keys.dart';

class NearbySearchAPI {
  // get destinations suggestions
  final String apiKey = gMapsWebApiKey;
  final String authority = 'maps.googleapis.com';
  //

  Future<List<PlaceMarkerModel>?> getNearestPlaces(
    LatLng location,
    String place,
    int radius,
  ) async {
    //
    const String unencodedpath = 'maps/api/place/nearbysearch/json';
    String? type;
    //
    switch (place.toLowerCase()) {
      case 'police stations':
        type = 'police';
        break;
      case 'fire stations':
        type = 'fire_station';
        break;
      case 'Hospitals':
        type = 'hospital';
        break;
      case 'gas stations':
        type = 'gas_station';
        break;
      case 'pharmacies':
        type = 'pharmacy';
        break;
      default:
    }
    //
    Map<String, dynamic> queryParams = {
      'keyword': place,
      'type': type,
      'radius': '$radius',
      'location': '${location.latitude},${location.longitude}',
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
      List<PlaceMarkerModel>? nearbyPlaces;
      //
      if (data['status'] == 'OK') {
        nearbyPlaces = [];
        //
        for (Map result in data['results']) {
          LatLng position = LatLng(
            result['geometry']['location']['lat'],
            result['geometry']['location']['lng'],
          );
          //
          PlaceMarkerModel nearbyPlace =
              PlaceMarkerModel(position, result['place_id']);
          //
          nearbyPlaces.add(nearbyPlace);
        }
      }
      //
      return nearbyPlaces;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
