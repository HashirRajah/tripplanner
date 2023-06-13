import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/blocs/reminders_bloc/reminders_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/reminders.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/reminders_app_bar.dart';
import 'package:tripplanner/services/firestore_services/reminders_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  //
  late final RemindersCRUD remindersCRUD;
  //
  @override
  void initState() {
    super.initState();
    //
    String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    remindersCRUD = RemindersCRUD(
      tripId: tripId,
      userId: userId,
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemindersBloc>(
      create: (context) => RemindersBloc(remindersCRUD)..add(LoadReminders()),
      child: StreamBuilder<int>(
          stream: remindersCRUD.remindersStream,
          builder: (context, snapshot) {
            //
            if (snapshot.hasData) {
              if (snapshot.data !=
                  BlocProvider.of<RemindersBloc>(context)
                      .cachedReminders
                      .length) {
                BlocProvider.of<RemindersBloc>(context).add(LoadReminders());
              }
            }
            //
            return const CustomScrollView(
              slivers: <Widget>[
                RemindersSliverAppBar(),
                SliverPadding(
                  padding: EdgeInsets.all(spacing_24),
                  sliver: Reminders(),
                ),
              ],
            );
          }),
    );
  }
}
