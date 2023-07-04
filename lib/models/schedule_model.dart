import 'package:tripplanner/models/visit_model.dart';

class ScheduleModel {
  final String date;
  final List<VisitModel> visits;
  //
  ScheduleModel({required this.date, required this.visits});
}
