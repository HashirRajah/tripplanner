import 'package:flutter/material.dart';
import 'package:tripplanner/screens/maps/n_map.dart';

class NearestPlacesMap extends StatelessWidget {
  final String title;
  //
  const NearestPlacesMap({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: NMap(
        place: title,
      ),
    );
  }
}
