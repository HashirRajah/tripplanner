import 'package:flutter/material.dart';
import 'package:tripplanner/models/expense_model.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/expense_detail_card.dart';
import 'package:tripplanner/shared/widgets/empty_sliver_list.dart';

class ExpensesList extends StatelessWidget {
  final String svgFilePath = 'assets/svgs/expenses.svg';
  final String message = 'No expense';
  final List<ExpenseModel> expenses;
  final Function delete;
  //
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return EmptySliverList(svgFilePath: svgFilePath, message: message);
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ExpenseCard(
              expense: expenses[index],
              index: index,
              delete: delete,
            );
          },
          childCount: expenses.length,
        ),
      );
    }
  }
}
