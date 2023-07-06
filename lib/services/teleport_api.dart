import 'dart:convert';
import 'package:http/http.dart';
import 'package:tripplanner/models/city_score_model.dart';
import 'package:tripplanner/models/score_model.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TeleportAPI {
  final String authority = 'api.teleport.org';
  //
  //
  Future<CityScoreModel?> getScores(String city) async {
    city = city.toLowerCase();
    //
    final String unencodedpath = 'api/urban_areas/slug:$city/scores/';
    //
    Uri url = Uri.https(
      authority,
      unencodedpath,
    );
    //

    //make request
    try {
      Response response = await get(url);
      final String? link = await getCityImage(city);
      Map data = jsonDecode(response.body);
      //
      List<ScoreModel> scores = [];
      //
      for (Map cat in data['categories']) {
        ScoreModel score = ScoreModel(
          score: cat['score_out_of_10'],
          category: cat['name'],
          color: colorFromHexCode(cat['color']),
        );
        //
        scores.add(score);
      }
      //
      CityScoreModel cityScoreModel = CityScoreModel(
        scores: scores,
        summary: data['summary'],
        imageLink: link!,
      );
      //
      return cityScoreModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //
  Future<String?> getCityImage(String city) async {
    city = city.toLowerCase();
    //
    final String unencodedpath = 'api/urban_areas/slug:$city/images/';
    //
    Uri url = Uri.https(
      authority,
      unencodedpath,
    );
    //

    //make request
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //
      //
      if (data['status'] != 404) {
        Map photo = data['photos'][0];
        final String link = photo['image']['mobile'];
        //
        return link;
      }
      return '';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
