import 'package:flutter/material.dart';
import 'package:tripplanner/models/budget_model.dart';
import 'package:tripplanner/models/destination_model.dart';

class TripModel {
  //
  final String? id;
  final String title;
  final DateTimeRange dates;
  final List<DestinationModel> destinations;
  BudgetModel? budget;
  //
  TripModel({
    this.id,
    required this.title,
    required this.dates,
    required this.destinations,
    this.budget,
  });
  //
  List<Map<String, dynamic>> getDestinationsMap() {
    return destinations
        .map((DestinationModel destination) => destination.getDestinationMap())
        .toList();
  }

  Map<String, dynamic>? getBudgetMap() {
    return budget?.getBudgetMap();
  }

  //
  static Map<String, dynamic> getTripSchema() {
    return {
      'title': null,
      'destinations': [],
      'start_date': null,
      'end_date': null,
      'is_shared': false,
      'shared_with': [],
      'notes': [],
      'budget': null,
      'flights': [],
      'hotel_bookings': [],
      'schedules': [],
    };
  }
}
