import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/currency_wrapper.dart';
import 'package:tripplanner/services/currency_exchange_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddExpenseForm extends StatefulWidget {
  //
  final String title;
  //
  const AddExpenseForm({super.key, required this.title});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _budgetFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _fromFocusNode = FocusNode();
  final FocusNode _budgetFocusNode = FocusNode();
  //
  String from = 'MUR';
  int budget = 0;
  final List<String> currencies = ['USD', 'MUR'];
  //
  bool processing = false;
  String errorTitle = 'An error occurred';
  String errorMessage = 'Could not edit budget';
  //
  final ValidationService validationService = ValidationService();

  //
  @override
  void initState() {
    //
    super.initState();
    //
    _budgetFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _budgetFormFieldKey, _budgetFocusNode));
  }

  //
  @override
  void dispose() {
    // dispose focus nodes
    _fromFocusNode.dispose();
    _budgetFocusNode.dispose();
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
    //
    if (validForm == true) {}
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
              value: from,
              items: currencies.map(currencyToMenuItem).toList(),
              onChanged: (value) {
                setState(() => from = value);
              },
              dropdownColor: searchBarColor,
              focusNode: _fromFocusNode,
            ),
          ),
          addVerticalSpace(spacing_16),
          TextFormField(
            key: _budgetFormFieldKey,
            initialValue: budget.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) {
              bool? valid = _budgetFormFieldKey.currentState?.validate();
              //
              if (valid == true) {
                setState(() => budget = int.parse(value));
              }
            },
            validator: (value) => validationService.validateNumber(value!),
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
