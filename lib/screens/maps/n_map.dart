import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tripplanner/models/place_card_model.dart';
import 'package:tripplanner/models/place_marker_model.dart';
import 'package:tripplanner/screens/maps/place_card.dart';
import 'package:tripplanner/screens/trip_screens/maps_screen/user_marker.dart';
import 'package:tripplanner/services/google_maps_services/nearbysearch_api.dart';
import 'package:tripplanner/services/google_maps_services/place_details_api.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tripplanner/shared/constants/api_keys.dart';

class NMap extends StatefulWidget {
  final String place;
  //
  const NMap({super.key, required this.place});

  @override
  State<NMap> createState() => _NMapState();
}

class _NMapState extends State<NMap> {
  //
  final Completer<GoogleMapController> _NMapController =
      Completer<GoogleMapController>();
  //
  final String svgFilePath = 'assets/svgs/maps.svg';
  final NearbySearchAPI nearbySearchAPI = NearbySearchAPI();
  final PlaceDetailsAPI placeDetailsAPI = PlaceDetailsAPI();
  //
  Location location = Location();
  late LocationData currentLocation;
  late LatLng currentLatLng;
  double initialZoom = 13.0;
  bool _hasPermission = false;
  bool loading = true;
  double radius = 5000;
  bool cardVisible = false;
  LatLng? destination;
  List<PlaceMarkerModel> placeMarkers = [];
  List<LatLng> polylineCoordinates = [];
  Set<Marker> markers = {};
  final Map<String, PlaceCardModel> cachedPlaceDetails = {};
  final String googleMapsAPIKey = gMapsWebApiKey;
  PlaceCardModel? placeCardModel;
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
    _NMapController.complete(controller);
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
    destination = currentLatLng;
    await getNearbyPlaces();
    await getRoute();
    //
    setState(() {
      loading = false;
    });
  }

  Future<void> getPlaceDetails(String placeId) async {
    //
    if (cachedPlaceDetails.containsKey(placeId)) {
      placeCardModel = cachedPlaceDetails[placeId];
      setState(() {
        cardVisible = true;
      });
      debugPrint('cached');
    } else {
      dynamic result = await placeDetailsAPI.getContactDetails(placeId);
      //
      if (result != null) {
        placeCardModel = result;
        cachedPlaceDetails[placeId] = result;
        //
        setState(() {
          cardVisible = true;
        });
      }
      //
    }
  }

  Future<void> getNearbyPlaces() async {
    int rad = radius.toInt();
    dynamic result = await nearbySearchAPI.getNearestPlaces(
        currentLatLng, widget.place, rad);
    //
    if (result != null) {
      placeMarkers = result;
      int i = 0;
      //
      for (PlaceMarkerModel place in placeMarkers) {
        if (i == 0) {
          destination = place.position;
          i++;
        }
        //
        markers.add(
          Marker(
            markerId: MarkerId(place.placeId),
            position: place.position,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            onTap: () async {
              destination = place.position;
              await getRoute();
              await getPlaceDetails(place.placeId);
              setState(() {});
            },
          ),
        );
      }
    }
  }

  //
  Future<void> getRoute() async {
    if (destination != null) {
      PolylinePoints plPoints = PolylinePoints();
      //
      PolylineResult result = await plPoints.getRouteBetweenCoordinates(
        googleMapsAPIKey,
        PointLatLng(currentLatLng.latitude, currentLatLng.longitude),
        PointLatLng(
          destination!.latitude,
          destination!.longitude,
        ),
      );
      print(result.errorMessage);
      //
      if (result.points.isNotEmpty) {
        polylineCoordinates.clear();
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
        //
      }
    }
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
  void dismissCard() {
    setState(() {
      cardVisible = false;
    });
  }

  //
  Widget buildCard() {
    if (cardVisible && placeCardModel != null) {
      return Positioned(
        top: spacing_16,
        child: PlaceCard(
          place: placeCardModel!,
          dismiss: dismissCard,
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
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: currentLatLng,
            zoom: initialZoom,
          ),
          onMapCreated: _onMapCreated,
          markers: markers,
          polylines: {
            Polyline(
              polylineId: const PolylineId('route'),
              points: polylineCoordinates,
              color: Colors.red[300]!,
              width: 5,
            ),
          },
          circles: {
            Circle(
              circleId: const CircleId('radius'),
              radius: radius,
              strokeWidth: 2,
              strokeColor: green_10,
              center: currentLatLng,
              fillColor: green_10.withOpacity(0.2),
            )
          },
        ),
        buildCard(),
        Padding(
          padding: const EdgeInsets.all(spacing_16),
          child: ElevatedButtonWrapper(
            childWidget: ElevatedButton.icon(
              onPressed: () async {
                if (destination != null) {
                  Uri url = Uri.parse(
                      'google.navigation:q=${destination!.latitude}, ${destination!.longitude}');
                  //
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
