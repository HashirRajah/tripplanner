import 'package:tripplanner/models/info_model.dart';

class VisaInfoModel {
  final String url;
  final String status;
  final List<InfoModel> requirements;
  final List<InfoModel> general;
  final List<InfoModel> restrictions;
  //
  VisaInfoModel({
    required this.url,
    required this.status,
    required this.requirements,
    required this.general,
    required this.restrictions,
  });
}
