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
import 'package:tripplanner/screens/trip_screens/maps_screen/visit_map_card.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/services/firestore_services/visit_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart' as ml;

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
  late final DateTime startDate;
  late final DateTime endDate;
  late final DateTime initialDate;
  late DateTime selectedDate;
  late final int daysCount;
  late final TripsCRUD tripsCRUD;
  late final VisitsCRUD visitsCRUD;
  bool loadingDates = true;
  List<VisitModel> visits = [];
  Set<Marker> markers = {};
  VisitMapPOICard? card;
  bool cardVisible = false;
  //
  @override
  void initState() {
    super.initState();
    //
    final String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    final String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    tripsCRUD = TripsCRUD(tripId: tripId);
    //
    visitsCRUD = VisitsCRUD(tripId: tripId, userId: userId);
    //
    getDates();
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
  Future<void> getDates() async {
    //
    dynamic result = await tripsCRUD.getStartAndEndDates();
    //
    startDate = DateTime.parse(result['start']);
    endDate = DateTime.parse(result['end']);
    DateTime today = DateTime.now();
    //
    if (today.isBefore(startDate)) {
      initialDate = startDate;
    } else if (today.isBefore(endDate)) {
      initialDate = today;
    } else {
      initialDate = endDate;
    }
    selectedDate = initialDate;
    //
    daysCount = endDate.difference(startDate).inDays + 1;
    //
    loadingDates = false;
    //
    await getVisits();
    //
    setState(() {});
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
    markers.add(userMarker(currentLatLng));
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
  Widget buildCard() {
    if (cardVisible && card != null) {
      return Positioned(
        top: (spacing_8 * 18),
        child: card!,
      );
    } else {
      return Container();
    }
  }

  //
  void markVisits() {
    for (VisitModel visit in visits) {
      if (visit.lat != null && visit.lng != null) {
        markers.add(
          Marker(
              markerId: MarkerId(visit.docId!),
              position: LatLng(visit.lat!, visit.lng!),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueMagenta,
              ),
              onTap: () {
                cardVisible = true;
                card = VisitMapPOICard(
                  visit: visit,
                  dismiss: dismissCard,
                );
                setState(() {});
              }),
        );
      }
    }
  }

  //
  void dismissCard() {
    setState(() {
      cardVisible = false;
    });
  }

  //
  Future<void> getVisits() async {
    //
    visits = await visitsCRUD.getVisitsForDate(selectedDate);
    //
    markVisits();
    //
    setState(() {});
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
  String getWayPoints() {
    String wayPoints = 'waypoints=';
    //
    for (int i = 0; i < visits.length - 2; i++) {
      if (visits[i].lat != null && visits[i].lng != null) {
        wayPoints += '${visits[i].lat}, ${visits[i].lng}|';
      }
    }
    //
    wayPoints = wayPoints.substring(0, wayPoints.length - 1);
    //
    return wayPoints;
  }

  String getDestination() {
    String destination = '';
    //
    for (int i = visits.length - 1; i >= 0; i--) {
      if (visits[i].lat != null && visits[i].lng != null) {
        destination = '${visits[i].lat}, ${visits[i].lng}';
        break;
      }
    }

    //
    return destination;
  }

  //
  List<ml.Coords> getWayPointsCoords() {
    List<ml.Coords> wayPoints = [];
    //
    for (VisitModel visit in visits) {
      if (visit.lat != null && visit.lng != null) {
        wayPoints.add(ml.Coords(visit.lat!, visit.lng!));
      }
    }
    //
    return wayPoints;
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
            target: currentLatLng,
            zoom: initialZoom,
          ),
          onMapCreated: _onMapCreated,
          markers: markers,
        ),
        Positioned(
          top: spacing_16,
          child: Container(
            padding: const EdgeInsets.all(spacing_16),
            height: spacing_120,
            width: getXPercentScreenWidth(90, screenWidth),
            decoration: BoxDecoration(
              color: docTileColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: loadingDates
                ? const SizedBox(
                    height: spacing_96,
                  )
                : DatePicker(
                    startDate,
                    height: spacing_96,
                    initialSelectedDate: initialDate,
                    selectionColor: green_10,
                    daysCount: daysCount,
                    onDateChange: (date) {
                      selectedDate = date;
                      //
                      resetMarkers();
                      //
                      getVisits();
                      //
                      setState(() {});
                    },
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(spacing_16),
          child: ElevatedButtonWrapper(
            childWidget: ElevatedButton.icon(
              onPressed: () async {
                if (visits.isNotEmpty) {
                  getWayPoints();
                  Uri url = Uri.parse(
                      'google.navigation:q=${getDestination()}&${getWayPoints()}');
                  // Uri url = Uri.parse(
                  //     'google.navigation:q=-20.31320905519105, 57.54114374418316&waypoints=-20.27940224414603, 57.50771011734996|-20.293771087246974, 57.51916785389578');
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
                }
              },
              icon: const Icon(Icons.route_outlined),
              label: const Text('Directions'),
            ),
          ),
        ),
        buildCard(),
      ],
    );
  }
}
