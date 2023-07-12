import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripplanner/models/city_boundary_model.dart';
import 'package:tripplanner/models/poi_model.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/map_poi_card.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class POIMap extends StatefulWidget {
  final String city;

  const POIMap({super.key, required this.city});

  @override
  State<POIMap> createState() => _POIMapState();
}

class _POIMapState extends State<POIMap> {
  //
  final Completer<GoogleMapController> _POIMapController =
      Completer<GoogleMapController>();
  //
  double initialZoom = 11.0;
  bool loading = true;
  bool error = false;
  final LocalService localService = LocalService();
  late Polygon polygon;
  late CityBoundaryModel cityBoundaryModel;
  Set<Marker> markers = {};
  MapPOICard? card;
  bool cardVisible = false;
  List<POIModel> pois = [];
  //
  @override
  void initState() {
    super.initState();
    //
    getCityBoundary();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  void _onMapCreated(GoogleMapController controller) {
    _POIMapController.complete(controller);
  }

  //
  Future<void> getPOIs() async {
    dynamic result = await localService.getPOIsForDestination(widget.city);
    //
    if (result != null) {
      pois = result;
      //
      for (POIModel poi in pois) {
        //
        LatLng position = LatLng(poi.lat!, poi.lng!);
        //
        markers.add(
          Marker(
            markerId: MarkerId(poi.id.toString()),
            position: position,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            onTap: () async {
              cardVisible = true;
              card = MapPOICard(
                poi: poi,
                dismiss: dismissCard,
              );
              setState(() {});
            },
          ),
        );
      }
    }
  }

  //
  //
  void dismissCard() {
    setState(() {
      cardVisible = false;
    });
  }

  //
  Future<void> getCityBoundary() async {
    //
    if (!loading) {
      setState(() {
        loading = true;
      });
    }
    //
    dynamic result = await localService.getCityBoundary(widget.city);
    //
    if (result != null) {
      cityBoundaryModel = result;
      debugPrint(cityBoundaryModel.boundary.length.toString());
      //
      polygon = Polygon(
        polygonId: const PolygonId('city-boundary'),
        points: cityBoundaryModel.boundary,
        fillColor: errorColor.withOpacity(0.1),
        strokeWidth: 2,
        strokeColor: errorColor,
      );
    } else {
      error = true;
    }
    //
    await getPOIs();
    //
    loading = false;
    //
    setState(() {});
  }

  //
  Widget buildCard() {
    if (cardVisible && card != null) {
      return Positioned(
        top: spacing_16,
        child: card!,
      );
    } else {
      return Container();
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (error) {
      return ErrorStateWidget(action: getCityBoundary);
    }
    //
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: cityBoundaryModel.cityLatLng,
            zoom: initialZoom,
          ),
          markers: markers,
          onMapCreated: _onMapCreated,
          polygons: {
            polygon,
          },
        ),
        buildCard(),
      ],
    );
  }
}
