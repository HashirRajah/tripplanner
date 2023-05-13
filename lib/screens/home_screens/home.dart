import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tripplanner/business_logic/cubits/page_index_cubit/page_index_cubit.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/explore_screen.dart';
import 'package:tripplanner/screens/home_screens/profile_screen/profile_screen.dart';
import 'package:tripplanner/screens/home_screens/trips_list_screen/add_button.dart';
import 'package:tripplanner/screens/home_screens/trips_list_screen/trips_list_screen.dart';
import 'package:tripplanner/shared/widgets/bottom_navigation.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class Home extends StatelessWidget {
  //
  final List<Widget> screens = const [
    ExploreScreen(),
    Center(
      child: Text('Hi'),
    ),
    TripsListScreen(),
    ProfileScreen()
  ];
  //
  final List<GButton> tabs = const [
    GButton(
      icon: Icons.explore_outlined,
      text: 'Explore',
    ),
    GButton(
      icon: Icons.search_outlined,
      text: 'Find',
    ),
    GButton(
      icon: Icons.card_travel_outlined,
      text: 'Trips',
    ),
    GButton(
      icon: Icons.person_outline,
      text: 'Profile',
    ),
  ];
  //
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PageIndexCubit>(
      create: (context) => PageIndexCubit(),
      child: GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: BlocBuilder<PageIndexCubit, PageIndexState>(
          builder: (context, state) {
            return Scaffold(
              //extendBodyBehindAppBar: true,
              bottomNavigationBar: BottomGNav(tabs: tabs),
              body: screens[state.pageIndex],
              floatingActionButton:
                  state.pageIndex == 2 ? const AddTrip() : null,
            );
          },
        ),
      ),
    );
  }
}
