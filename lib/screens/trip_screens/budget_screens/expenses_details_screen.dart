import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/blocs/budget_bloc/budget_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/expense_model.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/expenses_details_app_bar.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/expenses_list.dart';
import 'package:tripplanner/services/firestore_services/budget_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ExpensesDetailsScreen extends StatefulWidget {
  final String title;
  final List<ExpenseModel> expenses;
  final String type;
  //
  const ExpensesDetailsScreen({
    super.key,
    required this.title,
    required this.expenses,
    required this.type,
  });

  @override
  State<ExpensesDetailsScreen> createState() => _ExpensesDetailsScreenState();
}

class _ExpensesDetailsScreenState extends State<ExpensesDetailsScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late final BudgetCRUDServices budgetCRUDServices;
  late List<ExpenseModel> expensesList;
  late List<ExpenseModel> filteredExpensesList;
  //
  final String errorTitle = 'An error occurred';
  final String errorMessage = 'Could not delete expense';
  //

  @override
  void initState() {
    super.initState();
    //
    expensesList = List.from(widget.expenses);
    filteredExpensesList = List.from(expensesList);
    //
    String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    budgetCRUDServices = BudgetCRUDServices(tripId: tripId, userId: userId);
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  Future<void> deleteExpense(int index) async {
    dynamic result = await budgetCRUDServices.removeExpense(index, widget.type);
    //
    if (result == null) {
      setState(() {
        expensesList.removeAt(index);
        //
        filteredExpensesList = List.from(expensesList);
        //
        controller.clear();
      });
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
      }
    }
  }

  void goBack() {
    //
    if (expensesList.length != widget.expenses.length) {
      BlocProvider.of<BudgetBloc>(context).add(LoadBudget());
    }
    //
    Navigator.pop(context);
  }

  void search(BuildContext context, String query) {
    if (query == '') {
      setState(() {
        filteredExpensesList = List.from(expensesList);
      });
    } else {
      setState(() {
        filteredExpensesList = expensesList.where((ExpenseModel expense) {
          return expense.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            ExpensesSliverAppBar(
              controller: controller,
              expenseTitle: widget.title,
              action: goBack,
              search: search,
              focusNode: focusNode,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(spacing_16),
              sliver: ExpensesList(
                expenses: filteredExpensesList,
                delete: deleteExpense,
              ),
            )
          ],
        ),
      ),
    );
  }
}
