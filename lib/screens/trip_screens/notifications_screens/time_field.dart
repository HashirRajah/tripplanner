import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TimeField extends StatelessWidget {
  final TimeOfDay initialTime = TimeOfDay.now();
  TimeField({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showTimePicker(context: context, initialTime: initialTime);
      },
      child: Container(
        padding: const EdgeInsets.all(spacing_16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: tripCardColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(),
        ),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.timer_outlined,
              color: Colors.grey,
            ),
            addHorizontalSpace(spacing_16),
            const Text('Time'),
          ],
        ),
      ),
    );
  }
}
