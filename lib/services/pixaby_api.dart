import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tripplanner/shared/constants/api_keys.dart';

class PixabyAPI {
  // get destinations suggestions
  final String apiKey = pixabayAPIKey;
  final String authority = 'pixabay.com';
  //
  Future<String?> getImage(String query) async {
    //
    const String unencodedpath = 'api/';
    //
    Map<String, dynamic> queryParams = {
      'key': apiKey,
      'q': query,
      'safesearch': 'true'
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
      //debugPrint(data['hits'][0].toString());
      String imageUrl = '';
      //
      if (data['totalHits'] > 0) {
        imageUrl = data['hits'][0]['largeImageURL'];
      }
      //
      return imageUrl;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
