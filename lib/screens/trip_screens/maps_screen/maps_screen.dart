import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/maps_screen/map.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Maps'),
      ),
      body: const GMap(),
    );
  }
}
