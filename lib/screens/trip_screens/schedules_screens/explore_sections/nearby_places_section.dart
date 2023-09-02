import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/models/foursquare_place_model.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/plan_foursquare_card.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/foursquare_api.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class NearbyPlaces extends StatefulWidget {
  final double? lat;
  final double? lng;
  final DateTime startDate;
  final DateTime endDate;
  final Function addVisit;
  //
  const NearbyPlaces({
    super.key,
    required this.lat,
    required this.lng,
    required this.startDate,
    required this.endDate,
    required this.addVisit,
  });

  @override
  State<NearbyPlaces> createState() => _NearbyPlacesState();
}

class _NearbyPlacesState extends State<NearbyPlaces> {
  bool preferencesFetched = false;
  bool error = false;
  late String selectedPref;
  List<String> preferences = [];
  List<FourSquarePlaceModel> places = [];
  final LocalService localService = LocalService();
  final FourSquareAPI fourSquareAPI = FourSquareAPI();
  final String title = 'Nearby Places';
  late final UsersCRUD usersCRUD;
  late final String userId;
  LatLng? position;
  //
  @override
  void initState() {
    super.initState();
    //
    //
    userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    usersCRUD = UsersCRUD(uid: userId);
    //
    setPositionRelativeTo();
    //
    fetchPreferences();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  void setPositionRelativeTo() {
    if (widget.lat != null && widget.lng != null) {
      position = LatLng(widget.lat!, widget.lng!);
    }
  }

  //
  Future<void> fetchPreferences() async {
    preferences.add('Restaurants');
    preferences.add('Cafes');
    preferences.add('Malls');
    selectedPref = preferences[0];
    //
    setState(() {
      preferencesFetched = true;
    });
    //
    await fetchPlaces();
  }

  //
  Future<void> fetchPlaces() async {
    if (widget.lat != null && widget.lng != null) {
      places.clear();
      //
      dynamic result = await fourSquareAPI.getNearbyPlaces(
          selectedPref, widget.lat!, widget.lng!);
      //
      if (result != null) {
        places = result;
      }
      //
      setState(() {});
    }
  }

  //
  List<Widget> buildBody() {
    List<Widget> body = [];
    //
    body.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style:
              Theme.of(context).textTheme.titleLarge?.copyWith(color: green_10),
        ),
      ],
    ));
    //
    body.add(addVerticalSpace(spacing_8));

    //
    if (preferencesFetched && !error) {
      //
      body.add(SizedBox(
        height: (spacing_8 * 7),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                selectedPref = preferences[index];
                //
                await fetchPlaces();
                //
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(spacing_16),
                margin: const EdgeInsets.only(left: spacing_16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: selectedPref == preferences[index]
                      ? green_10
                      : tripCardColor,
                ),
                child: Text(
                  preferences[index],
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: selectedPref == preferences[index]
                            ? white_60
                            : Colors.black,
                      ),
                ),
              ),
            );
          },
          itemCount: preferences.length,
          scrollDirection: Axis.horizontal,
        ),
      ));
    }
    //
    body.add(addVerticalSpace(spacing_16));
    //
    body.add(SizedBox(
      height: (spacing_8 * 45),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return PlanFourSquareCard(
            place: places[index],
            startDate: widget.startDate,
            endDate: widget.endDate,
            userId: userId,
            addVisit: widget.addVisit,
            relativeTo: position,
          );
        },
        itemCount: places.length,
      ),
    ));
    //
    return body;
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Container(
      margin: const EdgeInsets.only(bottom: spacing_24),
      child: Column(
        children: buildBody(),
      ),
    );
  }
}
