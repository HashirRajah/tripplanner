import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/add_expense_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddExpense extends StatelessWidget {
  //
  final String title;
  final String type;
  final String currency;
  //
  const AddExpense({
    super.key,
    required this.title,
    required this.type,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(spacing_24),
        height: getXPercentScreenHeight(90, screenHeight),
        decoration: BoxDecoration(
          color: docTileColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Text(
              'Add',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: green_10,
                  ),
            ),
            addVerticalSpace(spacing_8),
            Text(
              '$title Expense',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: green_10,
                  ),
            ),
            addVerticalSpace(spacing_24),
            AddExpenseForm(
              title: 'Add',
              type: type,
              currentCurrency: currency,
            ),
          ],
        ),
      ),
    );
  }
}
