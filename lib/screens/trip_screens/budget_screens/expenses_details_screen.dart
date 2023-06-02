import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/expenses_details_app_bar.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ExpensesDetailsScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  //
  ExpensesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            ExpensesSliverAppBar(controller: controller),
            const SliverPadding(
              padding: EdgeInsets.all(spacing_16),
            )
          ],
        ),
      ),
    );
  }
}
