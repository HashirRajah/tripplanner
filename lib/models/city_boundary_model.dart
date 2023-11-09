import 'package:google_maps_flutter/google_maps_flutter.dart';

class CityBoundaryModel {
  final LatLng cityLatLng;
  final List<LatLng> boundary;
  //
  CityBoundaryModel({
    required this.cityLatLng,
    required this.boundary,
  });
}
