import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/blocs/budget_bloc/budget_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/chart.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/details.dart';
import 'package:tripplanner/services/firestore_services/budget_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //
    String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    final BudgetCRUDServices budgetServices =
        BudgetCRUDServices(tripId: tripId, userId: userId);
    //
    return BlocProvider<BudgetBloc>(
      create: (context) => BudgetBloc(budgetServices)..add(LoadBudget()),
      child: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            BudgetChart(),
            BudgetDetails(),
          ],
        ),
      ),
    );
  }
}
