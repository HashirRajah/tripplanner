import 'package:flutter/material.dart';
import 'package:tripplanner/screens/maps/poi_map.dart';

class POIMapScreen extends StatelessWidget {
  final String city;
  //
  const POIMapScreen({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Explore'),
      ),
      body: POIMap(
        city: city,
      ),
    );
  }
}
