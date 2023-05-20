import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/add_reminder_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddReminderButton extends StatelessWidget {
  const AddReminderButton({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return FloatingActionButton(
      onPressed: () {
        print('object');
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(spacing_16),
              height: getXPercentScreenHeight(60, screenHeight),
              decoration: BoxDecoration(
                color: docTileColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: const AddReminderForm(title: 'Save'),
            );
          },
        );
      },
      child: const Icon(Icons.add_alert_outlined),
    );
  }
}
