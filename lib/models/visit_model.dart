import 'package:google_maps_flutter/google_maps_flutter.dart';

class VisitModel {
  final dynamic id;
  final bool placeId;
  final bool fsqId;
  final bool poiId;
  final String name;
  final String? imageUrl;
  final int sequence;
  final LatLng? location;
  final Map<String, dynamic> additionalData;

  VisitModel({
    required this.id,
    required this.placeId,
    required this.fsqId,
    required this.poiId,
    required this.name,
    required this.imageUrl,
    required this.sequence,
    required this.location,
    required this.additionalData,
  });
  //
  Map<String, dynamic> getVisitMap() {
    return {
      'id': id,
      'place_id': placeId,
      'fsq_id': fsqId,
      'poi_id': poiId,
      'name': name,
      'image_url': imageUrl,
      'sequence': sequence,
      'location': location,
      'additionalData': additionalData,
    };
  }
}
