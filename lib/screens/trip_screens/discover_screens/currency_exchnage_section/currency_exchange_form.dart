import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/services/currency_exchange_services.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/dropdown_wrapper.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
  final _amountFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _fromFocusNode = FocusNode();
  final FocusNode _toFocusNode = FocusNode();
  final FocusNode _amountFocusNode = FocusNode();
  //
  String from = 'MUR';
  String to = 'USD';
  double amount = 1.0;
  double exchangeValue = 1.0;
  List<String> currencies = ['USD', 'MUR', 'EUR', 'GBP', 'AUD', 'CAD'];
  //
  bool processing = false;
  String errorTitle = 'An error occurred';
  String errorMessage = 'Could not get exchange rate';
  //
  late final TripsCRUD tripsCRUD;
  //
  final ValidationService validationService = ValidationService();
  final CurrencyExchangeService currencyExchangeService =
      CurrencyExchangeService();
  //
  @override
  void initState() {
    //
    super.initState();
    //
    String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    tripsCRUD = TripsCRUD(tripId: tripId);
    //
    _amountFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _amountFormFieldKey, _amountFocusNode));
    //
    getCurrencies();
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
  Future<void> getCurrencies() async {
    dynamic result = await tripsCRUD.getDestinationsCurrencies();
    //
    if (result.isNotEmpty) {
      for (String cur in result) {
        if (!currencies.contains(cur)) {
          currencies.add(cur);
        }
      }
      //
      setState(() {});
    }
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
  Future<void> _findAmount() async {
    //
    setState(() => processing = true);
    //
    bool? validForm = _formkey.currentState?.validate();
    //
    if (validForm == true) {
      dynamic result =
          await currencyExchangeService.getExchangeRate(from, to, amount);
      //
      if (result != null) {
        setState(() => exchangeValue = result);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
        }
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
          AnimatedTextKit(
            key: ValueKey(exchangeValue),
            isRepeatingAnimation: false,
            animatedTexts: [
              TyperAnimatedText(
                exchangeValue.toString(),
                textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: green_10,
                    ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
          ),
          addVerticalSpace(spacing_16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownWrapper(
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
              Icon(
                Icons.arrow_circle_right_outlined,
                color: green_10,
              ),
              DropdownWrapper(
                child: DropdownButton(
                  underline: Container(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  elevation: 0,
                  alignment: AlignmentDirectional.center,
                  borderRadius: BorderRadius.circular(15.0),
                  value: to,
                  items: currencies.map(currencyToMenuItem).toList(),
                  onChanged: (value) {
                    setState(() => to = value);
                  },
                  dropdownColor: searchBarColor,
                  focusNode: _toFocusNode,
                ),
              ),
            ],
          ),
          addVerticalSpace(spacing_16),
          TextFormField(
            key: _amountFormFieldKey,
            initialValue: amount.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) {
              bool? valid = _amountFormFieldKey.currentState?.validate();
              //
              if (valid == true) {
                setState(() => amount = double.parse(value));
              }
            },
            validator: (value) => validationService.validateNumber(value!),
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
              onPressed: () async {
                await _findAmount();
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
