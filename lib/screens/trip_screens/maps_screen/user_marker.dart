import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker userMarker(LatLng position) {
  const String markerId = 'user-marker';
  //
  return Marker(
    markerId: const MarkerId(markerId),
    position: position,
  );
}