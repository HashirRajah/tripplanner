class POIModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final String distance;
  final int likes;
  final int views;
  double? lat;
  double? lng;
  //
  POIModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.distance,
    required this.likes,
    required this.views,
    this.lat,
    this.lng,
  });
}
