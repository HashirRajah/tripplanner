import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/models/category_model.dart';
import 'package:tripplanner/models/foursquare_place_model.dart';
import 'package:tripplanner/models/simple_news_model.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/foursquare_card.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/foursquare_api.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/news_card.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class RecommendationSection extends StatefulWidget {
  final String destination;
  final LatLng? currentLocation;
  //
  const RecommendationSection({
    super.key,
    required this.destination,
    required this.currentLocation,
  });

  @override
  State<RecommendationSection> createState() => _RecommendationSectionState();
}

class _RecommendationSectionState extends State<RecommendationSection> {
  bool preferencesFetched = false;
  bool error = false;
  late String selectedPref;
  List<String> preferences = [];
  List<FourSquarePlaceModel> places = [];
  final LocalService localService = LocalService();
  final FourSquareAPI fourSquareAPI = FourSquareAPI();
  final String title = 'Other Places';
  late LatLng? cachedLocation;
  late final UsersCRUD usersCRUD;
  //
  @override
  void initState() {
    super.initState();
    //
    //
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    usersCRUD = UsersCRUD(uid: userId);
    //
    cachedLocation = widget.currentLocation;
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
  Future<void> fetchPreferences() async {
    //dynamic result = await usersCRUD.getAllPreferences();
    //
    // if (result != null) {
    //   //
    //   for (int id in result) {
    //     dynamic cat = await localService.getCategory(id);
    //     //
    //     if (cat != null) {
    //       preferences.add(cat);
    //     }
    //   }
    //   //
    //   error = false;
    // } else {
    //   error = true;
    // }
    //
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
    if (widget.currentLocation != null) {
      places.clear();
      //
      dynamic result = await fourSquareAPI.getNearbyPlaces(selectedPref,
          widget.currentLocation!.latitude, widget.currentLocation!.longitude);
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
    //
    if (widget.currentLocation != cachedLocation) {
      cachedLocation = widget.currentLocation;
      fetchPlaces();
    }
    //
    double screenHeight = getScreenHeight(context);
    //
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
    body.add(SizedBox(
      height: (spacing_8 * 45),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return FourSquareCard(
            place: places[index],
            open: true,
          );
        },
        itemCount: places.length,
      ),
    ));
    //
    // if (widget.currentLocation != null) {

    // } else {
    //   body.add(Center(
    //     child: Column(
    //       children: <Widget>[
    //         SvgPicture.asset(
    //           svgFilePath,
    //           height: getXPercentScreenHeight(50, screenHeight),
    //         ),
    //         addVerticalSpace(spacing_8),
    //         Text(
    //           'Need location permission',
    //           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
    //                 color: green_10,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //         ),
    //         addVerticalSpace(spacing_16),
    //         ElevatedButton.icon(
    //           onPressed: () async {
    //             await _checkServiceAndPermissions();
    //           },
    //           icon: const Icon(Icons.map_outlined),
    //           label: const Text('Give permission'),
    //         ),
    //       ],
    //     ),
    //   ));
    // }
    //
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
