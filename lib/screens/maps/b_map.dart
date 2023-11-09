import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripplanner/models/city_boundary_model.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class BMap extends StatefulWidget {
  final String city;

  const BMap({super.key, required this.city});

  @override
  State<BMap> createState() => _BMapState();
}

class _BMapState extends State<BMap> {
  //
  final Completer<GoogleMapController> _BMapController =
      Completer<GoogleMapController>();
  //
  double initialZoom = 11.0;
  bool loading = true;
  bool error = false;
  final LocalService localService = LocalService();
  late Polygon polygon;
  late CityBoundaryModel cityBoundaryModel;
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
    _BMapController.complete(controller);
  }

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
    loading = false;
    //
    setState(() {});
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
          onMapCreated: _onMapCreated,
          polygons: {
            polygon,
          },
        ),
      ],
    );
  }
}
