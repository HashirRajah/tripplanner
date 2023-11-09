import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tripplanner/business_logic/blocs/budget_bloc/budget_bloc.dart';
import 'package:tripplanner/models/budget_model.dart';
import 'package:tripplanner/models/expense_model.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/budget_chart_section.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class BudgetChart extends StatefulWidget {
  const BudgetChart({super.key});

  @override
  State<BudgetChart> createState() => _BudgetChartState();
}

class _BudgetChartState extends State<BudgetChart> {
  //
  int touchedIndex = 0;
  double getTotalExpenses(List<double> totalExpenses) {
    double total = 0;
    //
    for (double amount in totalExpenses) {
      total += amount;
    }
    //
    return total;
  }

  double getTotalSpecificExpenses(List<ExpenseModel> expenses) {
    double total = 0;
    //
    for (ExpenseModel expense in expenses) {
      total += expense.amount;
    }
    //
    return total;
  }

  //
  List<PieChartSectionData>? getSections(BudgetModel? budgetModel) {
    //
    double budget = 0.0;
    double totalExpenses = 0.0;
    double totalAirTicketExpenses = 0.0;
    double totalLodgingExpenses = 0.0;
    double totalTransportExpenses = 0.0;
    double totalActivityExpenses = 0.0;
    double totalOtherExpenses = 0.0;
    //
    if (budgetModel != null) {
      totalAirTicketExpenses =
          getTotalSpecificExpenses(budgetModel.airTicketExpenses);
      totalLodgingExpenses =
          getTotalSpecificExpenses(budgetModel.lodgingExpenses);
      totalTransportExpenses =
          getTotalSpecificExpenses(budgetModel.transportExpenses);
      totalActivityExpenses =
          getTotalSpecificExpenses(budgetModel.activityExpenses);
      totalOtherExpenses = getTotalSpecificExpenses(budgetModel.otherExpenses);
      //
      totalExpenses = getTotalExpenses([
        totalAirTicketExpenses,
        totalLodgingExpenses,
        totalTransportExpenses,
        totalActivityExpenses,
        totalOtherExpenses,
      ]);
      //
      if (budgetModel.budget == 0) {
        budgetModel.budget = totalExpenses.ceil();
      }
      budget =
          (((budgetModel.budget - totalExpenses) / budgetModel.budget) * 100);
      // calculate percentages
      totalAirTicketExpenses =
          ((totalAirTicketExpenses / budgetModel.budget) * 100);
      //
      totalLodgingExpenses =
          ((totalLodgingExpenses / budgetModel.budget) * 100);
      //
      totalTransportExpenses =
          ((totalTransportExpenses / budgetModel.budget) * 100);
      //
      totalActivityExpenses =
          ((totalActivityExpenses / budgetModel.budget) * 100);
      //
      totalOtherExpenses = ((totalOtherExpenses / budgetModel.budget) * 100);
    }
    //
    if ((totalExpenses + budget) == 0) {
      return null;
    }
    //
    List<PieChartSectionData> data = [
      chartDataSection(
        budget,
        Colors.amber[200]!,
        Colors.amber,
        Icons.monetization_on,
      ),
      chartDataSection(
        totalAirTicketExpenses,
        flightsCardColor,
        paletteOrange,
        Icons.airplane_ticket,
      ),
      chartDataSection(
        totalLodgingExpenses,
        hotelsCardColor,
        green_10,
        FontAwesomeIcons.hotel,
      ),
      chartDataSection(
        totalTransportExpenses,
        carRentalsCardColor,
        alternateGreen,
        FontAwesomeIcons.car,
      ),
      chartDataSection(
        totalActivityExpenses,
        airportTransfersCardColor,
        errorColor,
        Icons.local_activity,
      ),
      chartDataSection(
        totalOtherExpenses,
        Colors.purple[100]!,
        Colors.purple,
        Icons.menu,
      ),
    ];
    //
    return data;
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        BudgetModel? budget;
        //
        if (state is BudgetLoaded) {
          budget = state.budget;
        }
        //
        return Padding(
          padding: const EdgeInsets.all(spacing_16),
          child: Container(
            height: (spacing_8 * 40),
            decoration: BoxDecoration(
              color: green_10,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  centerSpaceRadius: 0.0,
                  sectionsSpace: 0.0,
                  sections: getSections(budget),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
