import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/add_reminder_form.dart';
import 'package:tripplanner/services/local_notifications_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddReminderButton extends StatelessWidget {
  final String title = 'Add Reminder';
  const AddReminderButton({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return FloatingActionButton(
      onPressed: () async {
        //
        LocalNotificationsService lnService = LocalNotificationsService();
        await lnService.checkAskAndroid13Permission();
        //
        if (context.mounted) {
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
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      addVerticalSpace(spacing_16),
                      BlocProvider.value(
                        value: BlocProvider.of<TripIdCubit>(context),
                        child: const AddReminderForm(title: 'Add'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
      child: const Icon(Icons.add_alert_outlined),
    );
  }
}
