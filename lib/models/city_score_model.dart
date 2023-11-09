import 'package:tripplanner/models/score_model.dart';
import 'package:html/parser.dart';

class CityScoreModel {
  final List<ScoreModel> scores;
  final String summary;
  final String imageLink;

  CityScoreModel({
    required this.scores,
    required this.summary,
    required this.imageLink,
  });
  //
  String getParsedSummary() {
    var doc = parse(summary);
    //
    return doc.documentElement!.text;
  }
}
