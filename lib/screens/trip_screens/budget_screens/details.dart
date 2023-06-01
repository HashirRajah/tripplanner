import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/budget_category.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/expenses_summary.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class BudgetDetails extends StatelessWidget {
  const BudgetDetails({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return Container(
      //height: getXPercentScreenHeight(50, screenHeight),
      width: double.infinity,
      decoration: BoxDecoration(
        color: docTileColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(spacing_72),
          topRight: Radius.circular(spacing_72),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(spacing_16),
        child: Column(
          children: <Widget>[
            const ExpensesSummary(
              budget: 10000,
              currency: 'MUR',
              totalExpenses: 200.0,
            ),
            addVerticalSpace(spacing_16),
            BudgetCategory(
              amount: 1012.99,
              iconData: Icons.airplane_ticket,
              text: 'Air Ticket',
              bgColor: flightsCardColor,
              buttonBgColor: alternateGreen,
            ),
            addVerticalSpace(spacing_16),
            BudgetCategory(
              amount: 12.99,
              iconData: FontAwesomeIcons.hotel,
              text: 'Lodging',
              bgColor: hotelsCardColor,
              buttonBgColor: alternateGreen,
            ),
            addVerticalSpace(spacing_16),
            BudgetCategory(
              amount: 12.99,
              iconData: FontAwesomeIcons.car,
              text: 'Transport',
              bgColor: carRentalsCardColor,
              buttonBgColor: alternateGreen,
            ),
            addVerticalSpace(spacing_16),
            BudgetCategory(
              amount: 1892.99,
              iconData: Icons.local_activity,
              text: 'Activities',
              bgColor: airportTransfersCardColor,
              buttonBgColor: alternateGreen,
            ),
          ],
        ),
      ),
    );
  }
}
