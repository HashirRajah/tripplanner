import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tripplanner/business_logic/cubits/cubit/page_index_cubit.dart';
import 'package:tripplanner/screens/find_screens/find_screen.dart';
import 'package:tripplanner/screens/trip_screens/back.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/documents_screen.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/add_notes_button.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/note_screen.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/notes_drawer/notes_drawer.dart';
import 'package:tripplanner/screens/trip_screens/notifications_button.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/bottom_navigation.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TripScreen extends StatelessWidget {
  // id of trip
  final String tripId;
  //
  final List<String> titles = [
    'Home',
    '',
    'Notes',
    'Budget',
    'Schedules',
  ];
  //
  final List<GButton> tabs = const [
    GButton(
      icon: Icons.home_outlined,
    ),
    GButton(
      icon: Icons.file_open_outlined,
    ),
    GButton(
      icon: Icons.note_alt_outlined,
    ),
    GButton(
      icon: Icons.attach_money_outlined,
      //text: 'Budget',
    ),
    GButton(
      icon: Icons.map_outlined,
    ),
  ];
  //
  final List<Widget> screens = [
    const Center(
      child: Text('Home'),
    ),
    const DocumentsScreen(),
    const NotesScreen(),
    const Center(
      child: Text('Budget'),
    ),
    const Center(
      child: Text('maps'),
    ),
  ];
  //
  TripScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PageIndexCubit>(
      create: (context) => PageIndexCubit(),
      child: GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: BlocBuilder<PageIndexCubit, PageIndexState>(
          builder: (context, state) {
            AppBar? appBar;
            //
            if (state.pageIndex != 2) {
              appBar = AppBar(
                elevation: 0.0,
                systemOverlayStyle: overlayStyle,
                centerTitle: true,
                title: Text(titles[state.pageIndex]),
                leading: const TripsBackButton(),
                actions: const <Widget>[
                  NotificationsButton(),
                ],
              );
            }
            //
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: appBar,
              bottomNavigationBar: BottomGNav(tabs: tabs),
              drawer: state.pageIndex == 2 ? const NotesDrawer() : null,
              body: screens[state.pageIndex],
              floatingActionButton:
                  state.pageIndex == 2 ? const AddNotesButton() : null,
            );
          },
        ),
      ),
    );
  }
}
