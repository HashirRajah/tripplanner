import 'dart:async';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/visit_model.dart';
import 'package:tripplanner/screens/trip_screens/maps_screen/user_marker.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/services/firestore_services/visit_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart' as ml;

class SimpleMapWithDirections extends StatefulWidget {
  final LatLng place;

  const SimpleMapWithDirections({
    super.key,
    required this.place,
  });

  @override
  State<SimpleMapWithDirections> createState() =>
      _SimpleMapWithDirectionsState();
}

class _SimpleMapWithDirectionsState extends State<SimpleMapWithDirections> {
  //
  final Completer<GoogleMapController> _SimpleMapWithDirectionsController =
      Completer<GoogleMapController>();
  //
  final String svgFilePath = 'assets/svgs/maps.svg';
  //
  Location location = Location();
  late LocationData currentLocation;
  late LatLng currentLatLng;
  double initialZoom = 16.0;
  bool _hasPermission = false;
  bool loading = true;
  //
  Set<Marker> markers = {};
  //
  @override
  void initState() {
    super.initState();
    _checkServiceAndPermissions();
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
    _SimpleMapWithDirectionsController.complete(controller);
  }

  Future<void> getCurrentLocation() async {
    //
    if (!loading) {
      setState(() {
        loading = true;
      });
    }
    //
    currentLocation = await location.getLocation();
    //
    currentLatLng =
        LatLng(currentLocation.latitude!, currentLocation.longitude!);
    //
    markers.add(userMarker(currentLatLng));
    markers.add(Marker(
      markerId: const MarkerId('destination'),
      position: widget.place,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
    ));
    //
    setState(() {
      loading = false;
    });
  }

  //
  void resetMarkers() {
    markers.removeWhere((element) {
      return element.markerId.value != 'user-marker';
    });
  }

  //
  Future<void> _checkServiceAndPermissions() async {
    //
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    //
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        setState(() {
          loading = false;
          _hasPermission = false;
        });
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setState(() {
          loading = false;
          _hasPermission = false;
        });
        return;
      }
    }
    //
    if (!_hasPermission) {
      setState(() {
        _hasPermission = true;
      });
    }
    //
    await getCurrentLocation();
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);
    //
    if (loading && _hasPermission) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (!_hasPermission) {
      return Center(
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              svgFilePath,
              height: getXPercentScreenHeight(50, screenHeight),
            ),
            addVerticalSpace(spacing_8),
            Text(
              'Need location permission',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: green_10,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            addVerticalSpace(spacing_16),
            ElevatedButton.icon(
              onPressed: () async {
                await _checkServiceAndPermissions();
              },
              icon: const Icon(Icons.map_outlined),
              label: const Text('Give permission'),
            ),
          ],
        ),
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
        Padding(
          padding: const EdgeInsets.all(spacing_16),
          child: ElevatedButtonWrapper(
            childWidget: ElevatedButton.icon(
              onPressed: () async {
                Uri url = Uri.parse(
                    'google.navigation:q=${widget.place.latitude}, ${widget.place.longitude}');
                //
                bool? petalForDemo =
                    await ml.MapLauncher.isMapAvailable(ml.MapType.petal);
                if (petalForDemo == true) {
                  ml.MapLauncher.showDirections(
                    mapType: ml.MapType.petal,
                    origin: ml.Coords(-20.220463236296574, 57.43138223492699),
                    destination:
                        ml.Coords(-20.276490298522766, 57.518079720932),
                    waypoints: [
                      ml.Coords(-20.243975132507487, 57.45390407978891),
                      ml.Coords(-20.262334597754915, 57.483687327670424),
                    ],
                  );
                } else {
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                }
              },
              icon: const Icon(Icons.route_outlined),
              label: const Text('Directions'),
            ),
          ),
        ),
      ],
    );
  }
}
