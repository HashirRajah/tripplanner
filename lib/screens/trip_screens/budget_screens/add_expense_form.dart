import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/blocs/budget_bloc/budget_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/expense_model.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/currency_wrapper.dart';
import 'package:tripplanner/services/currency_exchange_services.dart';
import 'package:tripplanner/services/firestore_services/budget_crud_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddExpenseForm extends StatefulWidget {
  //
  final String title;
  final String type;
  final String currentCurrency;
  //
  const AddExpenseForm({
    super.key,
    required this.title,
    required this.type,
    required this.currentCurrency,
  });

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm>
    with SingleTickerProviderStateMixin {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _expenseFormFieldKey = GlobalKey<FormFieldState>();
  final _titleFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _currencyFocusNode = FocusNode();
  final FocusNode _expenseFocusNode = FocusNode();
  final FocusNode _titleFocusNode = FocusNode();
  //
  String title = '';
  String currency = 'MUR';
  double expense = 1.0;
  final List<String> currencies = ['USD', 'MUR'];
  //
  bool processing = false;
  String errorTitle = 'An error occurred';
  String errorMessage = 'Could not add expense';
  //
  final ValidationService validationService = ValidationService();
  final CurrencyExchangeService currencyExchangeService =
      CurrencyExchangeService();
  late final BudgetCRUDServices budgetCRUDServices;
  //
  final String successMessage = 'Expense added';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
    //
    String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    budgetCRUDServices = BudgetCRUDServices(tripId: tripId, userId: userId);
    //
    _expenseFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _expenseFormFieldKey, _expenseFocusNode));
    //
    _titleFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(_titleFormFieldKey, _titleFocusNode));
    //
    controller = AnimationController(vsync: this);
    //
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.popUntil(context, (route) => route.settings.name == '/trips');
        BlocProvider.of<BudgetBloc>(context).add(LoadBudget());
        controller.reset();
      }
    });
  }

  //
  @override
  void dispose() {
    // dispose focus nodes
    _currencyFocusNode.dispose();
    _expenseFocusNode.dispose();
    //
    controller.dispose();
    //
    super.dispose();
  }

  //
  DropdownMenuItem currencyToMenuItem(String currency) {
    return DropdownMenuItem(
      value: currency,
      alignment: AlignmentDirectional.center,
      child: Text(currency),
    );
  }

  //
  //
  Future<void> _addExpense() async {
    //
    bool? validForm = _formkey.currentState?.validate();
    //
    if (validForm == true) {
      //
      if (currency != widget.currentCurrency) {
        double? expenseConverted = await currencyExchangeService
            .getExchangeRate(currency, widget.currentCurrency, expense);
        //
        if (expenseConverted != null) {
          expense = expenseConverted;
        }
      }
      //
      ExpenseModel expenseToAdd = ExpenseModel(
        title: title,
        dateAdded: DateTime.now().toIso8601String(),
        amount: expense,
      );
      //
      setState(() => processing = true);
      //
      dynamic result =
          await budgetCRUDServices.addExpense(widget.type, expenseToAdd);
      //
      setState(() => processing = false);
      //
      if (context.mounted) {
        if (result == null) {
          messageDialog(context, successMessage, successLottieFilePath,
              controller, false);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
        }
      }
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          addVerticalSpace(spacing_16),
          TextFormField(
            key: _titleFormFieldKey,
            initialValue: title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) => setState(() => title = value),
            validator: (value) => validationService.validateTitle(title),
            onEditingComplete: () => _titleFocusNode.unfocus(),
            decoration: InputDecoration(
              filled: true,
              fillColor: searchBarColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefixIcon: const Icon(Icons.title),
              hintText: 'Title',
            ),
            focusNode: _titleFocusNode,
            keyboardType: TextInputType.text,
          ),
          addVerticalSpace(spacing_16),
          CurrencyWrapper(
            child: DropdownButton(
              underline: Container(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              elevation: 0,
              alignment: AlignmentDirectional.center,
              borderRadius: BorderRadius.circular(15.0),
              value: currency,
              items: currencies.map(currencyToMenuItem).toList(),
              onChanged: (value) {
                setState(() => currency = value);
              },
              dropdownColor: searchBarColor,
              focusNode: _currencyFocusNode,
            ),
          ),
          addVerticalSpace(spacing_16),
          TextFormField(
            key: _expenseFormFieldKey,
            initialValue: expense.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) {
              bool? valid = _expenseFormFieldKey.currentState?.validate();
              //
              if (valid == true) {
                setState(() => expense = double.parse(value));
              }
            },
            validator: (value) => validationService.validateNumber(value!),
            onEditingComplete: () => _expenseFocusNode.unfocus(),
            decoration: InputDecoration(
              filled: true,
              fillColor: searchBarColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefixIcon: const Icon(Icons.numbers),
              hintText: 'Expense',
            ),
            focusNode: _expenseFocusNode,
            keyboardType: TextInputType.number,
          ),
          addVerticalSpace(spacing_16),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () async {
                await _addExpense();
              },
              child: ButtonChildProcessing(
                processing: processing,
                title: widget.title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
