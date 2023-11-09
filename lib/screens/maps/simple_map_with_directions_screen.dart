import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripplanner/screens/maps/simple_map_with_directions.dart';

class SimpleMapWithDirectionsScreen extends StatelessWidget {
  final LatLng place;
  //
  const SimpleMapWithDirectionsScreen({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Maps'),
      ),
      body: SimpleMapWithDirections(place: place),
    );
  }
}
