import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripplanner/models/osm_poi_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/osm_map_card.dart';

class SimpleMapMultiple extends StatefulWidget {
  final List<OSMPOIModel> places;
  //
  const SimpleMapMultiple({super.key, required this.places});

  @override
  State<SimpleMapMultiple> createState() => _SimpleMapMultipleState();
}

class _SimpleMapMultipleState extends State<SimpleMapMultiple> {
  //
  final Completer<GoogleMapController> _SimpleMapMultipleController =
      Completer<GoogleMapController>();
  double initialZoom = 15.0;
  bool loading = true;
  Set<Marker> markers = {};
  bool cardVisible = false;
  OSMMapCard? placeCard;
  //
  @override
  void initState() {
    super.initState();
    //
    fillMarkers();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  void _onSimpleMapMultipleCreated(GoogleMapController controller) {
    _SimpleMapMultipleController.complete(controller);
  }

  //
  void fillMarkers() {
    for (int i = 0; i < widget.places.length; i++) {
      markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: widget.places[i].position,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen,
        ),
        onTap: () {
          //
          placeCard = OSMMapCard(
            place: widget.places[i],
            dismiss: dismissCard,
          );
          cardVisible = true;
          //
          setState(() {});
        },
      ));
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
  Widget buildCard() {
    if (cardVisible && placeCard != null) {
      return Positioned(
        top: spacing_16,
        child: placeCard!,
      );
    } else {
      return Container();
    }
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
            target: widget.places[0].position,
            zoom: initialZoom,
          ),
          onMapCreated: _onSimpleMapMultipleCreated,
          markers: markers,
        ),
        buildCard(),
      ],
    );
  }
}
