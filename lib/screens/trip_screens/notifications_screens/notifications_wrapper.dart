import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/add_reminder_button.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/reminders_screen.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class NotificationsScreenWrapper extends StatelessWidget {
  const NotificationsScreenWrapper({super.key});
  //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: const Scaffold(
        body: RemindersScreen(),
        floatingActionButton: AddReminderButton(),
      ),
    );
  }
}
