import 'package:intl/intl.dart';

class TripCardModel {
  String id;
  String title;
  String startDate;
  String endDate;
  //
  final DateFormat dateFormat = DateFormat.yMMMd();
  //
  TripCardModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
  });

  String getDateFormatted() {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    //
    return '${dateFormat.format(start)} - ${dateFormat.format(end)}';
  }
}
