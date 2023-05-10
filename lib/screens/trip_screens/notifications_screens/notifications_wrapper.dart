import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tripplanner/business_logic/cubits/cubit/page_index_cubit.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/add_reminder_button.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/notifications_screen.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/reminders_screen.dart';
import 'package:tripplanner/shared/widgets/bottom_navigation.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class NotificationsScreenWrapper extends StatelessWidget {
  //
  //
  const NotificationsScreenWrapper({super.key});
  //
  final List<Widget> screens = const [
    NotificationsScreen(),
    RemindersScreen(),
  ];
  //
  final List<GButton> tabs = const [
    GButton(
      icon: Icons.notifications_none_outlined,
      text: 'Notifications',
    ),
    GButton(
      icon: Icons.notifications_active_outlined,
      text: 'Reminders',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PageIndexCubit>(
      create: (context) => PageIndexCubit(),
      child: BlocBuilder<PageIndexCubit, PageIndexState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => dismissKeyboard(context),
            child: Scaffold(
              bottomNavigationBar: BottomGNav(tabs: tabs),
              body: screens[state.pageIndex],
              floatingActionButton:
                  state.pageIndex == 1 ? const AddReminderButton() : null,
            ),
          );
        },
      ),
    );
  }
}
