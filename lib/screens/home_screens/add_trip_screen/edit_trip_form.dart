import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/budget_model.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/models/trip_details_model.dart';
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

class EditTripForm extends StatefulWidget {
  //
  final String title;
  final Function reload;
  //
  const EditTripForm({
    super.key,
    required this.title,
    required this.reload,
  });

  @override
  State<EditTripForm> createState() => _EditTripFormState();
}

class _EditTripFormState extends State<EditTripForm>
    with SingleTickerProviderStateMixin {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _titleFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _titleFocusNode = FocusNode();
  //
  final ValidationService validationService = ValidationService();
  final TripsCRUD tripService = TripsCRUD();
  //
  String tripTitle = '';
  int? budget;
  List<DestinationModel> destinations = [];
  DateTimeRange? selectedDates;
  late final String tripId;
  //
  bool processing = false;
  bool loading = true;
  //
  final String successMessage = 'Trip Saved';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
    //
    tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    //
    fetchTripDetails();
    //
    _titleFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(_titleFormFieldKey, _titleFocusNode));

    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.popUntil(context, (route) => route.settings.name == '/trips');
        widget.reload();
        controller.reset();
      }
    });
  }

  //
  @override
  void dispose() {
    // dispose focus nodes
    _titleFocusNode.dispose();
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
  Future<void> fetchTripDetails() async {
    dynamic result = await tripService.getTripDetails(
      tripId,
    );
    //
    if (result != null) {
      TripDetailsModel tripDetails = result;
      //
      tripTitle = tripDetails.title;
      destinations = tripDetails.destinations;
      selectedDates = DateTimeRange(
        start: DateTime.parse(tripDetails.startDate),
        end: DateTime.parse(tripDetails.endDate),
      );
      //
    }
    //
    setState(() {
      loading = false;
    });
  }

  //
  Future<void> _saveTrip() async {
    //
    String errorTitle = 'Failed to edit trip';
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
      TripDetailsModel trip = TripDetailsModel(
        id: tripId,
        title: tripTitle,
        startDate: selectedDates!.start.toIso8601String(),
        endDate: selectedDates!.end.toIso8601String(),
        destinations: destinations,
      );
      //
      dynamic result = await tripService.editTrip(trip);
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
      child: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                TextFormField(
                  key: _titleFormFieldKey,
                  initialValue: tripTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  onChanged: (value) => setState(() => tripTitle = value),
                  onEditingComplete: () => _titleFocusNode.unfocus(),
                  validator: (value) =>
                      validationService.validateTitle(tripTitle),
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
                  initialSelectedDates: selectedDates,
                ),
                addVerticalSpace(spacing_16),
                ElevatedButtonWrapper(
                  childWidget: ElevatedButton(
                    onPressed: () async => _saveTrip(),
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
