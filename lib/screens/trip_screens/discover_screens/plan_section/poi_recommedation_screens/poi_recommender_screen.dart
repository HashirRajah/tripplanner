import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/plan_section/poi_recommedation_screens/poi_recommender_app_bar.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/plan_section/poi_recommedation_screens/popular_section.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/plan_section/poi_recommedation_screens/recommended_section.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class POIRecommendationScreen extends StatefulWidget {
  const POIRecommendationScreen({super.key});

  @override
  State<POIRecommendationScreen> createState() =>
      _POIRecommendationScreenState();
}

class _POIRecommendationScreenState extends State<POIRecommendationScreen> {
  //
  //
  late TripsCRUD tripsCRUD;
  List<DestinationModel> destinations = [];
  DestinationModel? selectedDestination;
  late String userId;
  List<int> likes = [];
  late UsersCRUD usersCRUD;
  //
  //
  @override
  void initState() {
    super.initState();
    //
    userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    usersCRUD = UsersCRUD(uid: userId);
    //
    tripsCRUD = TripsCRUD(tripId: BlocProvider.of<TripIdCubit>(context).tripId);
    loadDestinations();
    getLikes();
  }

  //
  Future<void> loadDestinations() async {
    List<DestinationModel> dest = await tripsCRUD.getAllDestinations();
    //
    setState(() {
      destinations = dest;
      selectedDestination = dest[0];
    });
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
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
  List<Widget> buidDestinations() {
    List<Widget> destinationTiles = [];
    //
    for (var destination in destinations) {
      destinationTiles.add(GestureDetector(
        onTap: () {
          setState(() {
            selectedDestination = destination;
          });
          //
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(spacing_8),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on),
                  addHorizontalSpace(spacing_16),
                  Text(
                    destination.description,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              addVerticalSpace(spacing_8),
              const Divider(),
            ],
          ),
        ),
      ));
    }
    //
    return destinationTiles;
  }

  //
  void changeDestination() {
    //
    //
    double screenHeight = getScreenHeight(context);
    //
    showModalBottomSheet(
      clipBehavior: Clip.hardEdge,
      backgroundColor: docTileColor,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (newContext) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(spacing_16),
            height: getXPercentScreenHeight(60, screenHeight),
            decoration: BoxDecoration(
              color: docTileColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Select a destination',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                addVerticalSpace(spacing_16),
                Column(
                  children: buidDestinations(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //
  Widget buildBody() {
    if (selectedDestination != null) {
      //
      List<Widget> bodyWidgets = [];
      //
      bodyWidgets.add(POIRecommendationSliverAppBar(
        destination: selectedDestination!,
        function: changeDestination,
      ));
      //
      bodyWidgets.add(SliverPadding(
        padding: const EdgeInsets.all(spacing_16),
        sliver: RecommendedPOISection(
          destination: selectedDestination!.description,
          uid: userId,
          likes: likes,
          updateLikes: updateLikes,
        ),
      ));
      //
      bodyWidgets.add(SliverPadding(
        padding: const EdgeInsets.all(spacing_16),
        sliver: PopularPOISection(
          destination: selectedDestination!.description,
          uid: userId,
          likes: likes,
          updateLikes: updateLikes,
        ),
      ));
      //
      return CustomScrollView(
        slivers: bodyWidgets,
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }
}
