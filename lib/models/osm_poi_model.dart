import 'package:google_maps_flutter/google_maps_flutter.dart';

class OSMPOIModel {
  final LatLng position;
  final String type;
  final Map<String, dynamic> tags;
  //
  OSMPOIModel(this.position, this.type, this.tags);
}
