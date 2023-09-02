import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripplanner/screens/trip_screens/maps_screen/user_marker.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class MapRelativeTo extends StatefulWidget {
  final LatLng place;
  final LatLng? relativeTo;

  const MapRelativeTo({
    super.key,
    required this.place,
    required this.relativeTo,
  });

  @override
  State<MapRelativeTo> createState() => _MapRelativeToState();
}

class _MapRelativeToState extends State<MapRelativeTo> {
  //
  final Completer<GoogleMapController> _MapRelativeToController =
      Completer<GoogleMapController>();
  //
  //
  double initialZoom = 13.0;
  bool loading = true;
  //
  Set<Marker> markers = {};
  //
  @override
  void initState() {
    super.initState();
    //
    setMarkers();
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
    _MapRelativeToController.complete(controller);
  }

  //
  void setMarkers() {
    markers.add(Marker(
      markerId: const MarkerId('destination'),
      position: widget.place,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
    ));
    //
    if (widget.relativeTo != null) {
      markers.add(userMarker(widget.relativeTo!));
    }
    //
    setState(() {
      loading = false;
    });
  }

  //
  Widget buildInfoCard() {
    if (widget.relativeTo != null) {
      return Positioned(
        bottom: spacing_16,
        left: spacing_16,
        child: Card(
          elevation: 3.0,
          color: tripCardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(spacing_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.purple,
                    ),
                    addHorizontalSpace(spacing_16),
                    Text(
                      'Nearby Place',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                addVerticalSpace(spacing_16),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    addHorizontalSpace(spacing_16),
                    Text(
                      'Place of Interest',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    //
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.place,
            zoom: initialZoom,
          ),
          onMapCreated: _onMapCreated,
          markers: markers,
        ),
        buildInfoCard(),
      ],
    );
  }
}
