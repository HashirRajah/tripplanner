import 'package:flutter/material.dart';
import 'package:tripplanner/screens/maps/b_map.dart';

class BoundaryMap extends StatelessWidget {
  final String city;
  //
  const BoundaryMap({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Maps'),
      ),
      body: BMap(
        city: city,
      ),
    );
  }
}
