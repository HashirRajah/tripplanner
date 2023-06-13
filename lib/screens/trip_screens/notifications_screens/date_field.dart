import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DateField extends StatefulWidget {
  final Function updateDate;
  final String? dateTime;
  //
  const DateField({
    super.key,
    required this.updateDate,
    this.dateTime,
  });

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  DateTime? selectedDate;
  final DateTime initialDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('EEEE MMMM d, yyyy');
  //
  @override
  void initState() {
    super.initState();
    //
    if (widget.dateTime != null) {
      selectedDate = DateTime.parse(widget.dateTime!);
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: initialDate,
          lastDate: initialDate.add(const Duration(days: 366)),
        );
        //
        if (date != null) {
          widget.updateDate(date);
          //
          setState(() {
            selectedDate = date;
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
              Icons.date_range_outlined,
              color: Colors.grey,
            ),
            addHorizontalSpace(spacing_16),
            Text(
              selectedDate == null ? 'Date' : dateFormat.format(selectedDate!),
            ),
          ],
        ),
      ),
    );
  }
}
