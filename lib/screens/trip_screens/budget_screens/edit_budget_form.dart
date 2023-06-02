import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/blocs/budget_bloc/budget_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/currency_wrapper.dart';
import 'package:tripplanner/services/firestore_services/budget_crud_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EditBudgetForm extends StatefulWidget {
  //
  final String title;
  final String currentCurrency;
  final int currentBudget;
  //
  const EditBudgetForm({
    super.key,
    required this.title,
    required this.currentCurrency,
    required this.currentBudget,
  });

  @override
  State<EditBudgetForm> createState() => _EditBudgetFormState();
}

class _EditBudgetFormState extends State<EditBudgetForm>
    with SingleTickerProviderStateMixin {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _budgetFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _currencyFocusNode = FocusNode();
  final FocusNode _budgetFocusNode = FocusNode();
  //
  String currency = 'MUR';
  late int budget;
  final List<String> currencies = ['USD', 'MUR'];
  //
  bool processing = false;
  String errorTitle = 'An error occurred';
  String errorMessage = '';
  //
  final ValidationService validationService = ValidationService();
  late final BudgetCRUDServices budgetCRUDServices;
  //
  final String successMessage = 'Budget updated';
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
    budget = widget.currentBudget;
    //
    budgetCRUDServices = BudgetCRUDServices(tripId: tripId, userId: userId);
    //
    _budgetFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _budgetFormFieldKey, _budgetFocusNode));
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
    _budgetFocusNode.dispose();
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
  Future<void> _editBudget() async {
    //
    setState(() => processing = true);
    //
    bool? validForm = _formkey.currentState?.validate();
    bool errorOccurred = false;
    //
    if (validForm == true) {
      if (budget != widget.currentBudget) {
        dynamic result = await budgetCRUDServices.updateBudgetAmount(budget);
        //
        if (result != null) {
          if (context.mounted) {
            errorOccurred = true;
            //
            errorMessage = 'Could not update budget';
            //
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
          }
        }
      } //
      if (currency != widget.currentCurrency) {
        dynamic result = await budgetCRUDServices.updateBudgetCurrency(
            widget.currentCurrency, currency);
        //
        if (result != null) {
          if (context.mounted) {
            errorOccurred = true;
            //
            errorMessage = 'Could not update currency';
            //
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
          }
        }
      }
      //
      if (context.mounted && !errorOccurred) {
        messageDialog(
            context, successMessage, successLottieFilePath, controller, false);
      }
    }
    //
    setState(() => processing = false);
  }

  //
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
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
            key: _budgetFormFieldKey,
            initialValue: budget.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) {
              if (value == '') {
                budget = 0;
              } else {
                bool? valid = _budgetFormFieldKey.currentState?.validate();
                //
                if (valid == true) {
                  setState(() => budget = int.parse(value));
                }
              }
            },
            validator: (value) => validationService.validateWholeNumber(value!),
            onEditingComplete: () => _budgetFocusNode.unfocus(),
            decoration: InputDecoration(
              filled: true,
              fillColor: searchBarColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefixIcon: const Icon(Icons.attach_money_outlined),
              hintText: 'Budget',
            ),
            focusNode: _budgetFocusNode,
            keyboardType: TextInputType.number,
          ),
          addVerticalSpace(spacing_16),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () async {
                await _editBudget();
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
