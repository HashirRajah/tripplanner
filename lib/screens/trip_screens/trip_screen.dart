import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tripplanner/shared/widgets/bottom_navigation.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TripScreen extends StatefulWidget {
  //
  final List<Widget> screens = const [
    Center(
      child: Text('Home'),
    ),
    Center(
      child: Text('Documents'),
    ),
    Center(
      child: Text('Notes'),
    ),
    Center(
      child: Text('Maps'),
    ),
  ];
  //
  final List<GButton> tabs = const [
    GButton(
      icon: Icons.home_outlined,
      text: 'Home',
    ),
    GButton(
      icon: Icons.file_open_outlined,
      text: 'Documents',
    ),
    GButton(
      icon: Icons.note_alt_outlined,
      text: 'Notes',
    ),
    GButton(
      icon: Icons.map_outlined,
      text: 'Maps',
    ),
  ];
  //
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  // index of current screen
  int _currentScreenIndex = 0;
  //
  void _changeScreen(int index) {
    setState(() => _currentScreenIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
        bottomNavigationBar:
            BottomGNav(tabs: widget.tabs, changeScreen: _changeScreen),
        body: widget.screens[_currentScreenIndex],
      ),
    );
  }
}
