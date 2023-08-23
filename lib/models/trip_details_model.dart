import 'package:intl/intl.dart';
import 'package:tripplanner/models/destination_model.dart';

class TripDetailsModel {
  //
  final String id;
  final String title;
  final String startDate;
  final String endDate;
  final List<DestinationModel> destinations;
  //
  //
  final DateFormat dateFormat = DateFormat.yMMMd();
  //
  TripDetailsModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.destinations,
  });
  //
  String getDateFormatted() {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    //
    return '${dateFormat.format(start)} - ${dateFormat.format(end)}';
  }

  //
  List<Map<String, dynamic>> getDestinationsMap() {
    return destinations
        .map((DestinationModel destination) => destination.getDestinationMap())
        .toList();
  }

  //
  Map<String, dynamic> getTripMap() {
    return {
      'title': title,
      'destinations': getDestinationsMap(),
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
