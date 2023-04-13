import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tripplanner/screens/home_screens/profile_screen/profile_screen.dart';
import 'package:tripplanner/shared/widgets/bottom_navigation.dart';

class Home extends StatefulWidget {
  //
  final List<Widget> screens = const [
    Center(
      child: Text('Hi'),
    ),
    Placeholder(),
    Placeholder(),
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
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // index of current screen
  int _currentScreenIndex = 0;
  //
  void _changeScreen(int index) {
    setState(() => _currentScreenIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BottomGNav(tabs: widget.tabs, changeScreen: _changeScreen),
      body: widget.screens[_currentScreenIndex],
    );
  }
}
