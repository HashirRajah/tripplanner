import 'package:flutter/material.dart';
import 'package:tripplanner/models/budget_model.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class TripModel {
  //
  final String? id;
  final String title;
  final DateTimeRange dates;
  final List<DestinationModel> destinations;
  final BudgetModel budget;
  //
  TripModel({
    this.id,
    required this.title,
    required this.dates,
    required this.destinations,
    required this.budget,
  });
  //
  List<Map<String, dynamic>> getDestinationsMap() {
    return destinations
        .map((DestinationModel destination) => destination.getDestinationMap())
        .toList();
  }

  //
  Map<String, dynamic> getTripSchema() {
    return {
      'title': title,
      'destinations': getDestinationsMap(),
      'start_date': dates.start.toIso8601String(),
      'end_date': dates.end.toIso8601String(),
      'is_shared': false,
      // 'shared_with': [],
      // 'flights': [],
      // 'hotel_bookings': [],
      // 'schedules': [],
    };
  }
}
