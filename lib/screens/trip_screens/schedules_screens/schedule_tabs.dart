import 'package:flutter/material.dart';
import 'package:tripplanner/screens/find_screens/find_screen.dart';

class ScheduleTabs extends StatelessWidget {
  const ScheduleTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: <Widget>[
        Center(
          child: Text('Explore'),
        ),
        Center(
          child: Text('Schedules'),
        ),
      ],
    );
  }
}
