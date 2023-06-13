import 'package:flutter/material.dart';
import 'package:tripplanner/models/reminder_model.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/reminder_card.dart';
import 'package:tripplanner/shared/widgets/empty_sliver_list.dart';

class RemindersList extends StatelessWidget {
  final String svgFilePath = 'assets/svgs/no_reminders.svg';
  final String message = 'No reminders';
  final List<ReminderModel> reminders;
  //
  const RemindersList({super.key, required this.reminders});

  @override
  Widget build(BuildContext context) {
    if (reminders.isEmpty) {
      return EmptySliverList(svgFilePath: svgFilePath, message: message);
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ReminderCard(reminder: reminders[index]);
          },
          childCount: reminders.length,
        ),
      );
    }
  }
}
