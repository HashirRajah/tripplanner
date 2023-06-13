import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tripplanner/business_logic/blocs/reminders_bloc/reminders_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/reminder_model.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/edit_note_button.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/note_star_button.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/edit_reminder_form.dart';
import 'package:tripplanner/services/firestore_services/reminders_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ReminderCard extends StatefulWidget {
  //
  final ReminderModel reminder;
  //
  const ReminderCard({
    super.key,
    required this.reminder,
  });

  @override
  State<ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  //
  late RemindersCRUD remindersCRUD;
  //
  final String error = 'Unexpected Error';
  final String message = 'Could not delete reminder';
  //
  @override
  void initState() {
    super.initState();
    //
    String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    remindersCRUD = RemindersCRUD(
      reminderId: widget.reminder.id,
      tripId: tripId,
      userId: userId,
    );
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  Future<void> deleteReminder() async {
    dynamic result = await remindersCRUD.deleteReminder(widget.reminder);
    //
    if (result != null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar(context, error, message));
      }
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return Container(
      margin: const EdgeInsets.only(
        bottom: spacing_8,
      ),
      child: Stack(
        children: [
          Card(
            color: tripCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 3.0,
            child: Container(
              padding: const EdgeInsets.all(spacing_16),
              //height: spacing_112,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.reminder.memo, //widget.trip.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  addVerticalSpace(spacing_16),
                  Row(
                    children: [
                      const Icon(Icons.date_range_outlined),
                      addHorizontalSpace(spacing_8),
                      Text(
                        widget.reminder
                            .getDateFormatted(), //widget.trip.getDateFormatted(),
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                  addVerticalSpace(spacing_16),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                      ),
                      addHorizontalSpace(spacing_8),
                      Text(
                        widget.reminder.time, //widget.trip.getDateFormatted(),
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: spacing_16,
            top: spacing_16,
            child: CircleAvatar(
              backgroundColor: green_10,
              child: IconButton(
                onPressed: () {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.confirm,
                    text: 'Delete reminder permanently',
                    confirmBtnColor: errorColor,
                    customAsset: 'assets/gifs/bin.gif',
                    onConfirmBtnTap: () async {
                      //
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      //
                      await deleteReminder();
                    },
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: airportTransfersCardColor,
                ),
              ),
            ),
          ),
          Positioned(
            right: spacing_16,
            bottom: spacing_16,
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  clipBehavior: Clip.hardEdge,
                  backgroundColor: docTileColor,
                  isDismissible: false,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  context: context,
                  builder: (newContext) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        padding: const EdgeInsets.all(spacing_16),
                        height: getXPercentScreenHeight(60, screenHeight),
                        decoration: BoxDecoration(
                          color: docTileColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Edit Reminder',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            addVerticalSpace(spacing_16),
                            MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: BlocProvider.of<TripIdCubit>(context),
                                ),
                                BlocProvider.value(
                                  value:
                                      BlocProvider.of<RemindersBloc>(context),
                                ),
                              ],
                              child: EditReminderForm(
                                title: 'Save',
                                reminder: widget.reminder,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }
}
