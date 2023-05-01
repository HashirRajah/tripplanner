import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:intl/intl.dart';

class DateRangeField extends StatefulWidget {
  final Function updateDates;
  const DateRangeField({super.key, required this.updateDates});

  @override
  State<DateRangeField> createState() => _DateRangeFieldState();
}

class _DateRangeFieldState extends State<DateRangeField> {
  //
  DateTimeRange? selectedDates;
  final DateFormat dateFormat = DateFormat.yMMMd();
  //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTimeRange? dates = await showDateRangePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 366)),
        );
        //
        if (dates != null) {
          setState(() {
            selectedDates = dates;
          });
          //
          widget.updateDates(selectedDates);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(spacing_16),
        decoration: BoxDecoration(
          color: searchBarColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Icon(
                  Icons.date_range_outlined,
                  color: green_30,
                ),
                addHorizontalSpace(spacing_8),
                Text(
                  selectedDates == null
                      ? 'Start Date'
                      : dateFormat.format(selectedDates!.start),
                  style: dateTextStyle,
                ),
              ],
            ),
            addHorizontalSpace(spacing_8),
            Icon(
              Icons.arrow_forward_outlined,
              color: green_10,
            ),
            addHorizontalSpace(spacing_8),
            Row(
              children: [
                Icon(
                  Icons.date_range_outlined,
                  color: green_30,
                ),
                addHorizontalSpace(spacing_8),
                Text(
                  selectedDates == null
                      ? 'End Date'
                      : dateFormat.format(selectedDates!.end),
                  style: dateTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
