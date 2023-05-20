import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/reminders_app_bar.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        RemindersSliverAppBar(),
      ],
    );
  }
}
