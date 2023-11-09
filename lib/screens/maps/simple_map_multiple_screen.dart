import 'package:flutter/material.dart';
import 'package:tripplanner/models/osm_poi_model.dart';
import 'package:tripplanner/screens/maps/simple_map_multiple.dart';

class SimpleMapMultipleScreen extends StatelessWidget {
  final List<OSMPOIModel> places;
  //
  const SimpleMapMultipleScreen({
    super.key,
    required this.places,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Maps'),
      ),
      body: SimpleMapMultiple(places: places),
    );
  }
}
