import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/chart.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/details.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //

    //
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          addVerticalSpace(spacing_80),
          const BudgetChart(),
          const BudgetDetails(),
        ],
      ),
    );
  }
}
