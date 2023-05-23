import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DateField extends StatelessWidget {
  final initialDate = DateTime.now();
  DateField({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: initialDate,
          lastDate: initialDate.add(const Duration(days: 366)),
        );
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
            const Text('Date'),
          ],
        ),
      ),
    );
  }
}
