import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/blocs/reminders_bloc/reminders_bloc.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/reminders_list.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/shared/widgets/loading_sliver_list.dart';

class Reminders extends StatefulWidget {
  //
  const Reminders({super.key});

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  //
  void reloadReminders() {
    BlocProvider.of<RemindersBloc>(context).add(LoadReminders());
  }

  //
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersBloc, RemindersState>(
      builder: (context, state) {
        // loading
        if (state is LoadingReminders) {
          return const LoadingSliverList();
        }
        // loaded
        if (state is RemindersLoaded) {
          return RemindersList(reminders: state.reminders);
        }

        return SliverToBoxAdapter(
          child: ErrorStateWidget(action: reloadReminders),
        );
      },
    );
  }
}
