import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TimeField extends StatefulWidget {
  final Function updateTime;
  //
  const TimeField({super.key, required this.updateTime});

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  final TimeOfDay initialTime = TimeOfDay.now();
  TimeOfDay? selectedTime;
  //
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        TimeOfDay? time =
            await showTimePicker(context: context, initialTime: initialTime);
        //
        if (time != null) {
          widget.updateTime(time);
          //
          setState(() {
            selectedTime = time;
          });
        }
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
            Text(
              selectedTime == null ? 'Time' : selectedTime!.format(context),
            ),
          ],
        ),
      ),
    );
  }
}
