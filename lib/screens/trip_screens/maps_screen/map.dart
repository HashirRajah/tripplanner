import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class GMap extends StatefulWidget {
  const GMap({super.key});

  @override
  State<GMap> createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  //
  final Completer<GoogleMapController> _gMapController =
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
  @override
  void initState() {
    super.initState();
    //
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
    _gMapController.complete(controller);
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
    setState(() {
      loading = false;
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
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: currentLatLng,
        zoom: initialZoom,
      ),
      onMapCreated: _onMapCreated,
    );
  }
}
