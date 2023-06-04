import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/blocs/budget_bloc/budget_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/edit_budget.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ExpensesSummary extends StatelessWidget {
  final int budget;
  final String currency;
  final double totalExpenses;
  //
  const ExpensesSummary({
    super.key,
    required this.budget,
    required this.currency,
    required this.totalExpenses,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(spacing_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                currency,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: green_10, fontWeight: FontWeight.bold),
              ),
              AnimatedTextKit(
                key: ValueKey(budget),
                isRepeatingAnimation: false,
                animatedTexts: [
                  TyperAnimatedText(
                    budget.toString(),
                    textStyle: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: green_10),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
              ),
              addVerticalSpace(spacing_8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total Expenses:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: green_10,
                        ),
                  ),
                  Text(
                    totalExpenses.toStringAsFixed(3),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: green_10,
                        ),
                  ),
                ],
              ),
              addVerticalSpace(spacing_8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Amount left:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: green_10,
                        ),
                  ),
                  Text(
                    (budget - totalExpenses).toStringAsFixed(3),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: errorColor,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: spacing_16,
          right: spacing_16,
          child: CircleAvatar(
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
                  builder: (newContext) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: BlocProvider.of<TripIdCubit>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<BudgetBloc>(context),
                        ),
                      ],
                      child: EditBudget(
                        currency: currency,
                        budget: budget,
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        )
      ],
    );
  }
}
