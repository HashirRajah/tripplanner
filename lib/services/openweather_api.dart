import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tripplanner/models/country_model.dart';
import 'package:tripplanner/models/weather_model.dart';
import 'package:tripplanner/shared/constants/api_keys.dart';

class OpenWeatherAPI {
  // get destinations suggestions
  final String apiKey = openWeatherAPIKey;
  final String authority = 'api.openweathermap.org';
  //

  Future<WeatherModel?> getCurrentWeather(double lat, double lng) async {
    //
    const String unencodedpath = 'data/2.5/weather';
    //
    Map<String, dynamic> queryParams = {
      'lat': '$lat',
      'lon': '$lng',
      'appid': apiKey,
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
        late WeatherModel weather;
        //

        //
        return null;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
