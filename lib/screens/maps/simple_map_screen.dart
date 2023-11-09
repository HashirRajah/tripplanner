import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripplanner/screens/maps/simple_map.dart';

class SimpleMapScreen extends StatelessWidget {
  final LatLng place;
  //
  const SimpleMapScreen({
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
      body: SimpleMap(place: place),
    );
  }
}
