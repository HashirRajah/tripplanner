import 'package:flutter/material.dart';
import 'package:tripplanner/models/budget_model.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/models/trip_model.dart';
import 'package:tripplanner/screens/home_screens/add_trip_screen/date_range_field.dart';
import 'package:tripplanner/screens/home_screens/add_trip_screen/destinations_field.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddTripForm extends StatefulWidget {
  //
  final String title;
  //
  const AddTripForm({super.key, required this.title});

  @override
  State<AddTripForm> createState() => _AddTripFormState();
}

class _AddTripFormState extends State<AddTripForm>
    with SingleTickerProviderStateMixin {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _titleFormFieldKey = GlobalKey<FormFieldState>();
  final _budgetFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _budgetFocusNode = FocusNode();
  //
  final ValidationService validationService = ValidationService();
  final TripsCRUD tripService = TripsCRUD();
  //
  String tripTitle = '';
  int? budget;
  List<DestinationModel> destinations = [];
  DateTimeRange? selectedDates;
  //
  bool processing = false;
  //
  final String successMessage = 'Trip Added';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
    //
    _titleFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(_titleFormFieldKey, _titleFocusNode));
    _budgetFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _budgetFormFieldKey, _budgetFocusNode));
    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.popUntil(context, (route) => route.isFirst);
        controller.reset();
      }
    });
  }

  //
  @override
  void dispose() {
    // dispose focus nodes
    _titleFocusNode.dispose();
    _budgetFocusNode.dispose();
    controller.dispose();
    //
    super.dispose();
  }

  // add destination
  void _addDestination(DestinationModel destination) {
    setState(() {
      destinations.add(destination);
    });
  }

  // remove destination
  void _removeDestination(int index) {
    setState(() {
      destinations.removeAt(index);
    });
  }

  //
  void _updateSelectedDates(DateTimeRange dates) {
    setState(() {
      selectedDates = dates;
    });
  }

  //
  Future<void> _addTrip() async {
    //
    String errorTitle = 'Failed to add trip';
    String errorMessage = '';
    // validate form
    bool validForm = _formkey.currentState!.validate();
    //
    String? destinationsError =
        validationService.validateDestinations(destinations);
    //
    if (destinationsError != null) {
      validForm = false;
      //
      errorMessage = destinationsError;
      //
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
      }
    }
    //
    String? datesError = validationService.validateDates(selectedDates);
    //
    if (datesError != null) {
      validForm = false;
      //
      errorMessage = datesError;
      //
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
      }
    }
    //
    if (validForm) {
      //
      setState(() => processing = true);
      //
      BudgetModel budgetModel;
      //
      if (budget != null) {
        budgetModel = BudgetModel(
          budget: budget!,
          currency: 'MUR',
          airTicketExpenses: [],
          lodgingExpenses: [],
          transportExpenses: [],
          activityExpenses: [],
          otherExpenses: [],
        );
      } else {
        budgetModel = BudgetModel(
          budget: 0,
          currency: 'MUR',
          airTicketExpenses: [],
          lodgingExpenses: [],
          transportExpenses: [],
          activityExpenses: [],
          otherExpenses: [],
        );
      }
      //
      TripModel trip = TripModel(
        id: null,
        title: tripTitle,
        dates: selectedDates!,
        destinations: destinations,
        budget: budgetModel,
      );
      //
      dynamic result = await tripService.addTrip(trip);
      //
      setState(() => processing = false);
      // check if errors
      if (result != null) {
        //
        errorMessage = result;
        //
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
        }
      } else if (result == null) {
        if (context.mounted) {
          messageDialog(context, successMessage, successLottieFilePath,
              controller, false);
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
          TextFormField(
            key: _titleFormFieldKey,
            initialValue: tripTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) => setState(() => tripTitle = value),
            onEditingComplete: () => _titleFocusNode.unfocus(),
            validator: (value) => validationService.validateTitle(tripTitle),
            decoration: InputDecoration(
              filled: true,
              fillColor: searchBarColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefixIcon: const Icon(Icons.title_outlined),
              hintText: 'Title',
            ),
            focusNode: _titleFocusNode,
            maxLength: 23,
          ),
          addVerticalSpace(spacing_16),
          DestinationsField(
            add: _addDestination,
            remove: _removeDestination,
            destinations: destinations,
          ),
          addVerticalSpace(spacing_16),
          DateRangeField(
            updateDates: _updateSelectedDates,
          ),
          addVerticalSpace(spacing_16),
          TextFormField(
            key: _budgetFormFieldKey,
            initialValue: budget?.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) {
              if (value != '') {
                bool? validBudget =
                    _budgetFormFieldKey.currentState?.validate();
                //
                print(value);
                if (validBudget == true) {
                  setState(() => budget = int.parse(value));
                }
                //
                _budgetFormFieldKey.currentState?.validate();
              } else {
                budget = null;
                //
                _budgetFormFieldKey.currentState?.validate();
              }
            },
            onEditingComplete: () => _budgetFocusNode.unfocus(),
            validator: (value) =>
                validationService.validateBudget(budget, value),
            decoration: InputDecoration(
              filled: true,
              fillColor: searchBarColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefixIcon: const Icon(Icons.attach_money_outlined),
              hintText: 'Budget (Optional)',
            ),
            focusNode: _budgetFocusNode,
            keyboardType: TextInputType.number,
            maxLength: 7,
          ),
          addVerticalSpace(spacing_16),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () async => _addTrip(),
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
