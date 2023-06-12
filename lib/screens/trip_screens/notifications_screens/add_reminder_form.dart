import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/reminder_model.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/date_field.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/time_field.dart';
import 'package:tripplanner/services/firestore_services/reminders_crud_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_row.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddReminderForm extends StatefulWidget {
  //
  final String title;
  //
  const AddReminderForm({super.key, required this.title});

  @override
  State<AddReminderForm> createState() => _AddReminderFormState();
}

class _AddReminderFormState extends State<AddReminderForm>
    with SingleTickerProviderStateMixin {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _memoFormFieldKey = GlobalKey<FormFieldState>();
  final _passwordFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _memoFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  //
  final ValidationService validationService = ValidationService();
  late final RemindersCRUD remindersCRUD;
  final DateFormat dateFormat = DateFormat.yMMMd();
  //
  String memo = '';
  DateTime? date;
  TimeOfDay? time;
  //
  bool processing = false;
  //
  final String successMessage = 'Reminder added';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  final String errorTitle = 'Failed to add reminder';
  String errorMessage = '';
  String dateErr = '';
  String timeErr = '';
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
    remindersCRUD = RemindersCRUD(
      tripId: tripId,
      userId: userId,
    );
    //
    _memoFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(_memoFormFieldKey, _memoFocusNode));
    _passwordFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _passwordFormFieldKey, _passwordFocusNode));
    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.popUntil(
          context,
          (route) => route.settings.name == '/notifications',
        );
        controller.reset();
      }
    });
  }

  //
  @override
  void dispose() {
    //
    super.dispose();
    // dispose focus nodes
    _memoFocusNode.dispose();
    _passwordFocusNode.dispose();
    controller.dispose();
  }

  //
  void _updateDate(DateTime selectedDate) {
    setState(() {
      date = selectedDate;
    });
  }

  //
  void _updateTime(TimeOfDay selectedTime) {
    setState(() {
      time = selectedTime;
    });
  }

  //
  Future _addReminder() async {
    // validate form
    bool validForm = _formkey.currentState!.validate();
    //
    String? dateError = validationService.validateDate(date);
    //
    if (dateError != null) {
      validForm = false;
      //
      setState(() {
        dateErr = dateError;
      });
    } else {
      setState(() {
        dateErr = '';
      });
    }
    //
    String? timeError = validationService.validateTime(time);
    //
    if (timeError != null) {
      validForm = false;
      //
      errorMessage = timeError;
      //
      setState(() {
        timeErr = timeError;
      });
    } else {
      setState(() {
        timeErr = '';
      });
    }
    //
    if (validForm) {
      ReminderModel reminder = ReminderModel(
        id: null,
        memo: memo,
        date: dateFormat.format(date!),
        time: time!.format(context),
      );
      //
      setState(() {
        processing = true;
      });
      //
      dynamic result = await remindersCRUD.addReminder(reminder);
      //
      setState(() {
        processing = false;
      });
      //
      if (result != null) {
      } else {
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
            key: _memoFormFieldKey,
            initialValue: memo,
            onChanged: (value) => setState(() => memo = value),
            onEditingComplete: () => _memoFocusNode.unfocus(),
            validator: (value) => validationService.validateMemo(memo),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.title),
              hintText: 'Memo',
              filled: true,
              fillColor: tripCardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            focusNode: _memoFocusNode,
          ),
          addVerticalSpace(spacing_32),
          DateField(
            updateDate: _updateDate,
          ),
          addVerticalSpace(spacing_8),
          ErrorRow(error: dateErr),
          addVerticalSpace(spacing_8),
          TimeField(
            updateTime: _updateTime,
          ),
          addVerticalSpace(spacing_8),
          ErrorRow(error: timeErr),
          addVerticalSpace(spacing_8),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () async {
                await _addReminder();
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
