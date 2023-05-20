import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tripplanner/business_logic/cubits/page_index_cubit/page_index_cubit.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/screens/trip_screens/back.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/discover_screen.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/documents_screen.dart';
import 'package:tripplanner/screens/trip_screens/maps_screen/maps_screen.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/add_notes_button.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/note_screen.dart';
import 'package:tripplanner/screens/trip_screens/notifications_button.dart';
import 'package:tripplanner/screens/trip_screens/schedules_screens/schedule_tabs.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/bottom_navigation.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TripScreen extends StatefulWidget {
  // id of trip
  final String tripId;

  const TripScreen({super.key, required this.tripId});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
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
      icon: Icons.location_on_outlined,
    ),
  ];

  //
  final List<Widget> screens = [
    const DiscoverScreen(),
    const DocumentsScreen(),
    NotesScreen(),
    const Center(
      child: Text('Budget'),
    ),
    const ScheduleTabs(),
  ];

  //
  final List<int> indexes = [1, 3, 4];
  //
  late final TripsCRUD tripsCRUD;
  //
  @override
  void initState() {
    super.initState();
    //
    tripsCRUD = TripsCRUD(tripId: widget.tripId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PageIndexCubit>(
          create: (context) => PageIndexCubit(),
        ),
        BlocProvider<TripIdCubit>(
          create: (context) => TripIdCubit(widget.tripId),
        ),
      ],
      child: GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: BlocBuilder<PageIndexCubit, PageIndexState>(
          builder: (context, state) {
            AppBar? appBar;
            //
            if (indexes.contains(state.pageIndex)) {
              if (state.pageIndex != 4) {
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
              } else {
                appBar = AppBar(
                  elevation: 0.0,
                  systemOverlayStyle: overlayStyle,
                  centerTitle: true,
                  title: Text(titles[state.pageIndex]),
                  leading: const TripsBackButton(),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MapsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.map_outlined),
                    ),
                    const NotificationsButton(),
                  ],
                  bottom: TabBar(
                    indicatorColor: green_30,
                    indicatorWeight: 3.0,
                    tabs: const <Widget>[
                      Tab(
                        icon: Icon(Icons.explore_outlined),
                      ),
                      Tab(
                        icon: Icon(Icons.calendar_month_outlined),
                      ),
                    ],
                  ),
                );
              }
            }
            //
            return DefaultTabController(
              length: state.pageIndex == 4 ? 2 : 0,
              child: Scaffold(
                extendBodyBehindAppBar: true,
                appBar: appBar,
                bottomNavigationBar: BottomGNav(tabs: tabs),
                body: screens[state.pageIndex],
                floatingActionButton:
                    state.pageIndex == 2 ? const AddNotesButton() : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
