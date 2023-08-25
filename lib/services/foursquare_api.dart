import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tripplanner/models/foursquare_place_model.dart';
import 'package:tripplanner/shared/constants/api_keys.dart';

class FourSquareAPI {
  // get destinations suggestions
  final String apiKey = foursquareAPIKey;
  final String authority = 'api.foursquare.com';
  //

  Future<List<FourSquarePlaceModel>?> getPlaces(
      String query, String near) async {
    //
    const String unencodedpath = 'v3/places/search';
    //
    Map<String, dynamic> queryParams = {
      "query": query,
      'near': near,
      'open_now': 'true',
      'sort': 'DISTANCE'
    };
    //
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": foursquareAPIKey,
    };
    //
    Uri url = Uri.https(
      authority,
      unencodedpath,
      queryParams,
    );
    //make request
    try {
      Response response = await get(url, headers: headers);
      Map data = jsonDecode(response.body);
      //debugPrint(data.toString());
      //
      if (response.statusCode == 200) {
        //
        List<FourSquarePlaceModel> places = [];
        //
        for (Map<String, dynamic> result in data['results']) {
          dynamic image = await getPlaceImage(result['fsq_id']);
          String imageUrl = '';

          if (image != null) {
            imageUrl = image;
          }

          FourSquarePlaceModel place = FourSquarePlaceModel(
            id: result['fsq_id'],
            name: result['name'],
            imageUrl: imageUrl,
            address: result['location']['formatted_address'],
            lat: result['geocodes']['main']['latitude'],
            lng: result['geocodes']['main']['longitude'],
          );
          //
          places.add(place);
        }
        //
        return places;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //
  Future<List<FourSquarePlaceModel>?> getNearbyPlaces(
      String query, double lat, double lng) async {
    //
    const String unencodedpath = 'v3/places/search';
    //
    Map<String, dynamic> queryParams = {
      "query": query,
      'll': '$lat,$lng',
      'open_now': 'true',
      'sort': 'DISTANCE'
    };
    //
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": foursquareAPIKey,
    };
    //
    Uri url = Uri.https(
      authority,
      unencodedpath,
      queryParams,
    );
    //make request
    try {
      Response response = await get(url, headers: headers);
      Map data = jsonDecode(response.body);
      //debugPrint(data.toString());
      //
      if (response.statusCode == 200) {
        //
        List<FourSquarePlaceModel> places = [];
        //
        for (Map<String, dynamic> result in data['results']) {
          dynamic image = await getPlaceImage(result['fsq_id']);
          String imageUrl = '';

          if (image != null) {
            imageUrl = image;
          }

          FourSquarePlaceModel place = FourSquarePlaceModel(
            id: result['fsq_id'],
            name: result['name'],
            imageUrl: imageUrl,
            address: result['location']['formatted_address'],
            lat: result['geocodes']['main']['latitude'],
            lng: result['geocodes']['main']['longitude'],
          );
          //
          places.add(place);
        }
        //
        return places;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //
  Future<String?> getPlaceImage(String fsqId) async {
    //
    final String unencodedpath = 'v3/places/$fsqId/photos';
    //
    Map<String, dynamic> queryParams = {
      "limit": '1',
    };
    //
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": foursquareAPIKey,
    };
    //
    Uri url = Uri.https(
      authority,
      unencodedpath,
      queryParams,
    );
    //make request
    try {
      Response response = await get(url, headers: headers);
      List<dynamic> data = jsonDecode(response.body);
      //debugPrint(data.toString());
      //
      if (response.statusCode == 200) {
        return '${data[0]["prefix"]}original${data[0]["suffix"]}';
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
