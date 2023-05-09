import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/cubit/page_index_cubit.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/notifications_screen.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/reminders_screen.dart';

class NotificationsScreenWrapper extends StatelessWidget {
  //
  //
  const NotificationsScreenWrapper({super.key});
  //
  final List<Widget> screens = const [
    NotificationsScreen(),
    RemindersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PageIndexCubit>(
      create: (context) => PageIndexCubit(),
      child: Scaffold(
        body: BlocBuilder<PageIndexCubit, PageIndexState>(
          builder: (context, state) => screens[state.pageIndex],
        ),
      ),
    );
  }
}
