import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/edit_budget_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EditBudget extends StatelessWidget {
  //
  final String currency;
  final int budget;
  //
  const EditBudget({
    super.key,
    required this.currency,
    required this.budget,
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
        height: getXPercentScreenHeight(80, screenHeight),
        decoration: BoxDecoration(
          color: docTileColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            addVerticalSpace(spacing_8),
            Text(
              'Edit Budget',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: green_10,
                  ),
            ),
            addVerticalSpace(spacing_24),
            EditBudgetForm(
              title: 'Save',
              currentCurrency: currency,
              currentBudget: budget,
            ),
          ],
        ),
      ),
    );
  }
}
