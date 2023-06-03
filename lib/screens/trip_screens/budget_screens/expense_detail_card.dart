import 'package:flutter/material.dart';
import 'package:tripplanner/models/expense_model.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/delete_expense_button.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ExpenseCard extends StatelessWidget {
  //
  final ExpenseModel expense;
  final int index;
  final Function delete;
  final String currency;
  //
  const ExpenseCard({
    super.key,
    required this.expense,
    required this.index,
    required this.delete,
    required this.currency,
  });

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: spacing_8,
      ),
      child: Stack(
        children: [
          Card(
            color: tripCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 3.0,
            child: Container(
              padding: const EdgeInsets.all(spacing_16),
              //height: spacing_112,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title, //widget.trip.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  addVerticalSpace(spacing_16),
                  Text(
                    '$currency ${expense.amount.toStringAsFixed(3)}', //widget.trip.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  addVerticalSpace(spacing_16),
                  Text(
                    expense
                        .getDateAddedFormatted(), //widget.trip.getDateFormatted(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: spacing_16,
            top: spacing_16,
            child: CircleAvatar(
              backgroundColor: green_10,
              child: DeleteExpenseButton(
                index: index,
                delete: delete,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
