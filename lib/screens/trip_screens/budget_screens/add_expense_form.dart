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
  final String type;
  //
  const AddExpenseForm({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _expenseFormFieldKey = GlobalKey<FormFieldState>();
  final _titleFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _fromFocusNode = FocusNode();
  final FocusNode _expenseFocusNode = FocusNode();
  final FocusNode _titleFocusNode = FocusNode();
  //
  String title = '';
  String from = 'MUR';
  double expense = 0;
  final List<String> currencies = ['USD', 'MUR'];
  //
  bool processing = false;
  String errorTitle = 'An error occurred';
  String errorMessage = 'Could not add expense';
  //
  final ValidationService validationService = ValidationService();
  //
  @override
  void initState() {
    //
    super.initState();
    //
    _expenseFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _expenseFormFieldKey, _expenseFocusNode));
    //
    _titleFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(_titleFormFieldKey, _titleFocusNode));
  }

  //
  @override
  void dispose() {
    // dispose focus nodes
    _fromFocusNode.dispose();
    _expenseFocusNode.dispose();
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
  Future<void> _editexpense() async {
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
          TextFormField(
            key: _titleFormFieldKey,
            initialValue: title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) {},
            validator: (value) {},
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
                await _editexpense();
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
