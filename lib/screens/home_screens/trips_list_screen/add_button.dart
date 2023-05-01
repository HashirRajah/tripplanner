import 'package:flutter/material.dart';
import 'package:tripplanner/screens/home_screens/add_trip_screen/add_trip_screen.dart';

class AddTrip extends StatelessWidget {
  const AddTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddTripScreen()),
        );
      },
      child: const Icon(Icons.add_outlined),
    );
  }
}
