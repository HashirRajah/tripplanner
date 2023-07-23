class VisitModel {
  String? docId;
  final dynamic id;
  final bool placeId;
  final bool fsqId;
  final bool poiId;
  final String name;
  final String? imageUrl;
  int sequence;
  final double? lat;
  final double? lng;
  final Map<String, dynamic> additionalData;
  final String addedBy;

  VisitModel({
    this.docId,
    required this.id,
    required this.placeId,
    required this.fsqId,
    required this.poiId,
    required this.name,
    required this.imageUrl,
    required this.sequence,
    required this.lat,
    required this.lng,
    required this.additionalData,
    required this.addedBy,
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
      'lat': lat,
      'lng': lng,
      'additional_data': additionalData,
      'added_by': addedBy,
    };
  }
}
