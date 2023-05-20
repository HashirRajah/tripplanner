import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class CurrencyExchangeForm extends StatefulWidget {
  //
  final String title;
  //
  const CurrencyExchangeForm({super.key, required this.title});

  @override
  State<CurrencyExchangeForm> createState() => _CurrencyExchangeFormState();
}

class _CurrencyExchangeFormState extends State<CurrencyExchangeForm> {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _fromFormFieldKey = GlobalKey<FormFieldState>();
  final _toFormFieldKey = GlobalKey<FormFieldState>();
  final _amountFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _fromFocusNode = FocusNode();
  final FocusNode _toFocusNode = FocusNode();
  final FocusNode _amountFocusNode = FocusNode();
  //
  String from = 'MUR';
  String to = 'USD';
  double amount = 0.0;
  final List<String> currencies = ['USD', 'MUR'];
  //
  bool processing = false;
  //
  @override
  void initState() {
    //
    super.initState();
    //
    _fromFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(_fromFormFieldKey, _fromFocusNode));
    _toFocusNode.addListener(
        () => validateTextFormFieldOnFocusLost(_toFormFieldKey, _toFocusNode));
    _amountFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _amountFormFieldKey, _amountFocusNode));
  }

  //
  @override
  void dispose() {
    // dispose focus nodes
    _fromFocusNode.dispose();
    _toFocusNode.dispose();
    _amountFocusNode.dispose();
    //
    super.dispose();
  }

  //
  DropdownMenuItem currencyToMenuItem(String currency) {
    return DropdownMenuItem(
      value: currency,
      child: Text(currency),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton(
                value: from,
                items: currencies.map(currencyToMenuItem).toList(),
                onChanged: (value) {},
                dropdownColor: searchBarColor,
              ),
              Icon(
                Icons.arrow_circle_right_outlined,
                color: green_10,
              ),
              DropdownButton(
                value: to,
                items: currencies.map(currencyToMenuItem).toList(),
                onChanged: (value) {},
                dropdownColor: searchBarColor,
              ),
            ],
          ),
          addVerticalSpace(spacing_16),
          TextFormField(
            key: _amountFormFieldKey,
            initialValue: amount.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) {},
            onEditingComplete: () => _amountFocusNode.unfocus(),
            decoration: InputDecoration(
              filled: true,
              fillColor: searchBarColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefixIcon: const Icon(Icons.numbers_outlined),
              hintText: 'Amount',
            ),
            focusNode: _amountFocusNode,
            keyboardType: TextInputType.number,
          ),
          addVerticalSpace(spacing_16),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () async {},
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
