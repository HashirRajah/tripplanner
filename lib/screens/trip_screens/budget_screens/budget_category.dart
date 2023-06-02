import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/add_expense.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/expenses_details_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class BudgetCategory extends StatelessWidget {
  final double amount;
  final IconData iconData;
  final String text;
  final Color bgColor;
  final Color buttonBgColor;
  //
  const BudgetCategory({
    super.key,
    required this.amount,
    required this.iconData,
    required this.text,
    required this.bgColor,
    required this.buttonBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spacing_16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    iconData,
                    color: green_10,
                    size: spacing_32,
                  ),
                  addHorizontalSpace(spacing_16),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: green_10,
                        ),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: green_10,
                foregroundColor: white_60,
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      enableDrag: false,
                      clipBehavior: Clip.hardEdge,
                      backgroundColor: docTileColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      builder: (context) {
                        return AddExpense(title: text);
                      },
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
          addVerticalSpace(spacing_8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                amount.toString(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: green_10,
                    ),
              ),
              CircleAvatar(
                backgroundColor: green_10,
                foregroundColor: white_60,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExpensesDetailsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward_outlined),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
