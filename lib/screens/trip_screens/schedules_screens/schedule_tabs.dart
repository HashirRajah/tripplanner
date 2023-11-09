import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/schedules_screens/explore_destination_screen.dart';
import 'package:tripplanner/screens/trip_screens/schedules_screens/schedule_screen.dart';

class ScheduleTabs extends StatelessWidget {
  const ScheduleTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: <Widget>[
        ExploreDestinationsScreen(),
        ScheduleScreen(),
      ],
    );
  }
}
