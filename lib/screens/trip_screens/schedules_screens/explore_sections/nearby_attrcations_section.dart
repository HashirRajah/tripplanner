import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tripplanner/models/osm_poi_model.dart';
import 'package:tripplanner/models/simple_news_model.dart';
import 'package:tripplanner/screens/maps/simple_map_multiple_screen.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/services/openstreetmap_api.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/news_card.dart';
import 'package:tripplanner/shared/widgets/osm_card.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class NearbyAttractionsSection extends StatefulWidget {
  final String destination;
  //
  const NearbyAttractionsSection({
    super.key,
    required this.destination,
  });

  @override
  State<NearbyAttractionsSection> createState() =>
      _NearbyAttractionsSectionState();
}

class _NearbyAttractionsSectionState extends State<NearbyAttractionsSection> {
  bool dataFetched = false;
  bool newsError = false;
  List<OSMPOIModel> places = [];
  final OpenStreetMapAPI openStreetMapAPI = OpenStreetMapAPI();
  final String title = 'Nearby places worth checking';
  late String cachedDestination;
  Location location = Location();
  late LocationData currentLocation;
  late LatLng currentLatLng;
  //
  @override
  void initState() {
    super.initState();
    //
    cachedDestination = widget.destination;
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
  Future<void> getCurrentLocation() async {
    currentLocation = await location.getLocation();
    //
    currentLatLng =
        LatLng(currentLocation.latitude!, currentLocation.longitude!);
    //
    await fetchPlaces();
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
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    //
    await getCurrentLocation();
  }

  //
  Future<void> fetchPlaces() async {
    //
    if (dataFetched) {
      setState(() {
        dataFetched = false;
      });
    }
    //
    dynamic result = await openStreetMapAPI.getNearbyAttractions(currentLatLng);
    //
    if (result == null) {
      newsError = true;
    } else {
      places = result;
    }
    //
    dataFetched = true;
    setState(() {});
  }

  //
  List<Widget> buildBody() {
    List<Widget> body = [];
    //
    body.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: green_10),
          ),
        ),
      ],
    ));
    //
    body.add(addVerticalSpace(spacing_16));
    body.add(
      Container(
        margin: const EdgeInsets.only(bottom: spacing_16),
        child: ElevatedButtonWrapper(
          childWidget: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SimpleMapMultipleScreen(places: places),
                ),
              );
            },
            icon: const Icon(Icons.map),
            label: const Text('View All'),
          ),
        ),
      ),
    );
    //
    if (dataFetched && !newsError) {
      body.add(SizedBox(
        height: (spacing_8 * 40),
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (places[index].tags.containsKey('name')) {
              return OSMCard(
                place: places[index],
              );
            } else {
              return Container();
            }
          },
          itemCount: places.length,
          scrollDirection: Axis.horizontal,
        ),
      ));
    }

    //
    return body;
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    if (cachedDestination != widget.destination) {
      cachedDestination = widget.destination;
    }
    return Container(
      margin: const EdgeInsets.only(bottom: spacing_24),
      child: Column(
        children: buildBody(),
      ),
    );
  }
}
