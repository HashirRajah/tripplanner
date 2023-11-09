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
      'units': 'metric'
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
        weather = WeatherModel(
          main: data['weather'][0]['main'],
          description: data['weather'][0]['description'],
          temp: data['main']['temp'],
          feelsLike: data['main']['feels_like'],
          min: data['main']['temp_min'],
          max: data['main']['temp_max'],
          humidity: data['main']['humidity'],
          wind: data['wind']['speed'],
        );
        //
        return weather;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
