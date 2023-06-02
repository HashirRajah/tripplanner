import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tripplanner/business_logic/blocs/budget_bloc/budget_bloc.dart';
import 'package:tripplanner/models/expense_model.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/budget_category.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/expenses_summary.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class BudgetDetails extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/error.svg';
  //
  const BudgetDetails({super.key});
  //
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
        child: BlocBuilder<BudgetBloc, BudgetState>(
          builder: (context, state) {
            //
            if (state is ErrorState) {
              return Center(
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      svgFilePath,
                      height: getXPercentScreenHeight(30, screenHeight),
                    ),
                    Text(
                      'An error ocurred!',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: green_10,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    addVerticalSpace(spacing_16),
                    CircleAvatar(
                      backgroundColor: green_10,
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<BudgetBloc>(context)
                              .add(LoadBudget());
                        },
                        icon: const Icon(Icons.replay_outlined),
                        color: white_60,
                      ),
                    ),
                  ],
                ),
              );
            }
            //
            int budget = 0;
            String currency = '';
            double totalExpenses = 0.0;
            double totalAirTicketExpenses = 0.0;
            double totalLodgingExpenses = 0.0;
            double totalTransportExpenses = 0.0;
            double totalActivityExpenses = 0.0;
            double totalOtherExpenses = 0.0;
            //
            if (state is BudgetLoaded) {
              budget = state.budget.budget;
              currency = state.budget.currency;
              //
              totalAirTicketExpenses =
                  getTotalSpecificExpenses(state.budget.airTicketExpenses);
              totalLodgingExpenses =
                  getTotalSpecificExpenses(state.budget.lodgingExpenses);
              totalTransportExpenses =
                  getTotalSpecificExpenses(state.budget.transportExpenses);
              totalActivityExpenses =
                  getTotalSpecificExpenses(state.budget.activityExpenses);
              totalOtherExpenses =
                  getTotalSpecificExpenses(state.budget.otherExpenses);
              //
              totalExpenses = getTotalExpenses([
                totalAirTicketExpenses,
                totalLodgingExpenses,
                totalTransportExpenses,
                totalActivityExpenses,
                totalOtherExpenses,
              ]);
            }
            //
            return Column(
              children: <Widget>[
                ExpensesSummary(
                  budget: budget,
                  currency: currency,
                  totalExpenses: totalExpenses,
                ),
                addVerticalSpace(spacing_16),
                BudgetCategory(
                  amount: totalAirTicketExpenses,
                  iconData: Icons.airplane_ticket,
                  text: 'Air Ticket',
                  type: 'air_ticket_expenses',
                  bgColor: flightsCardColor,
                  buttonBgColor: alternateGreen,
                ),
                addVerticalSpace(spacing_16),
                BudgetCategory(
                  amount: totalLodgingExpenses,
                  iconData: FontAwesomeIcons.hotel,
                  text: 'Lodging',
                  type: 'lodging_expenses',
                  bgColor: hotelsCardColor,
                  buttonBgColor: alternateGreen,
                ),
                addVerticalSpace(spacing_16),
                BudgetCategory(
                  amount: totalTransportExpenses,
                  iconData: FontAwesomeIcons.car,
                  text: 'Transport',
                  type: 'transport_expenses',
                  bgColor: carRentalsCardColor,
                  buttonBgColor: alternateGreen,
                ),
                addVerticalSpace(spacing_16),
                BudgetCategory(
                  amount: totalActivityExpenses,
                  iconData: Icons.local_activity,
                  text: 'Activities',
                  type: 'activity_expenses',
                  bgColor: airportTransfersCardColor,
                  buttonBgColor: alternateGreen,
                ),
                addVerticalSpace(spacing_16),
                BudgetCategory(
                  amount: totalOtherExpenses,
                  iconData: Icons.menu,
                  text: 'Other',
                  type: 'other_expenses',
                  bgColor: Colors.purple[100]!,
                  buttonBgColor: alternateGreen,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
