import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripplanner/models/city_boundary_model.dart';
import 'package:tripplanner/models/poi_model.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/map_poi_card.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  bool displayInfo = true;
  List<POIModel> pois = [];
  List<POIModel> recommendedPois = [];
  late String userId;
  List<int> likes = [];
  late UsersCRUD usersCRUD;

  //
  @override
  void initState() {
    super.initState();
    //
    userId = Provider.of<User?>(context, listen: false)!.uid;
    usersCRUD = UsersCRUD(uid: userId);
    //
    getCityBoundary();
    getLikes();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  Future<void> getLikes() async {
    dynamic result = await usersCRUD.getAllLikedPOIs();
    //
    if (result.length > 0) {
      setState(() {
        likes = result;
      });
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
      int k = (pois.length / 2).floor();
      //
      result = await localService.getPersonalizedPOIs(userId, k, widget.city);
      //
      if (result != null) {
        recommendedPois = result;
      }
      //
      for (POIModel poi in pois) {
        //
        LatLng position = LatLng(poi.lat!, poi.lng!);
        late BitmapDescriptor descriptor;
        //
        if (recommendedPois.map((POIModel p) => p.id).contains(poi.id)) {
          descriptor = BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueMagenta,
          );
        } else {
          descriptor = BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          );
        }
        //
        markers.add(
          Marker(
            markerId: MarkerId(poi.id.toString()),
            position: position,
            icon: descriptor,
            onTap: () async {
              cardVisible = true;
              card = MapPOICard(
                poi: poi,
                dismiss: dismissCard,
                userId: userId,
                liked: likes.contains(poi.id),
                updateLikes: updateLikes,
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
  void updateLikes(bool add, int id) {
    if (add) {
      likes.add(id);
    } else {
      likes.remove(id);
    }
    setState(() {});
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
  Widget buildInfoCard() {
    if (displayInfo) {
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
                      'Recommended',
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
                      color: Colors.green,
                    ),
                    addHorizontalSpace(spacing_16),
                    Text(
                      'All',
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
        buildInfoCard(),
      ],
    );
  }
}
