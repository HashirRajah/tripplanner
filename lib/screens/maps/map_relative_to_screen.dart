import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripplanner/screens/maps/map_relative_to.dart';
import 'package:tripplanner/screens/maps/simple_map_with_directions.dart';

class MapRelativeToScreen extends StatelessWidget {
  final LatLng place;
  final LatLng? relativeTo;
  //
  const MapRelativeToScreen({
    super.key,
    required this.place,
    required this.relativeTo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Maps'),
      ),
      body: MapRelativeTo(
        place: place,
        relativeTo: relativeTo,
      ),
    );
  }
}
