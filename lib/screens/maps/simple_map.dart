import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMap extends StatefulWidget {
  final LatLng place;
  //
  const SimpleMap({super.key, required this.place});

  @override
  State<SimpleMap> createState() => _SimpleMapState();
}

class _SimpleMapState extends State<SimpleMap> {
  //
  final Completer<GoogleMapController> _SimpleMapController =
      Completer<GoogleMapController>();
  double initialZoom = 16.0;
  bool loading = true;

  //
  @override
  void initState() {
    super.initState();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  void _onSimpleMapCreated(GoogleMapController controller) {
    _SimpleMapController.complete(controller);
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.place,
            zoom: initialZoom,
          ),
          onMapCreated: _onSimpleMapCreated,
          markers: {
            Marker(
              markerId: const MarkerId('place'),
              position: widget.place,
            ),
          },
        ),
      ],
    );
  }
}
