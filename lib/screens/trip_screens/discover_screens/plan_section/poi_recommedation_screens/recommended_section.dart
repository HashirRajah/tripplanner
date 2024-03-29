import 'package:flutter/material.dart';
import 'package:tripplanner/models/poi_model.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/poi_card.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class RecommendedPOISection extends StatefulWidget {
  final String destination;
  final String uid;
  final List<int> likes;
  final Function updateLikes;
  //
  const RecommendedPOISection({
    super.key,
    required this.destination,
    required this.uid,
    required this.likes,
    required this.updateLikes,
  });

  @override
  State<RecommendedPOISection> createState() => _RecommendedPOISectionState();
}

class _RecommendedPOISectionState extends State<RecommendedPOISection> {
  final String title = 'Recommended for you';
  final LocalService localService = LocalService();
  List<POIModel> pois = [];
  late String cachedDestination;
  //
  @override
  void initState() {
    super.initState();
    //
    cachedDestination = widget.destination;
    //
    getPOIs();
  }

  //
  Future<void> getPOIs() async {
    dynamic result = await localService.getPersonalizedPOIs(
      widget.uid,
      25,
      widget.destination.toLowerCase(),
    );
    //
    if (result != null) {
      setState(() {
        pois = result;
      });
    }
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    if (cachedDestination != widget.destination) {
      getPOIs();
      cachedDestination = widget.destination;
    }
    //
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: green_10,
                ),
          ),
          addVerticalSpace(spacing_16),
          SizedBox(
            height: (spacing_8 * 40),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return POICard(
                  type: 'recommended',
                  poi: pois[index],
                  userId: widget.uid,
                  liked: widget.likes.contains(pois[index].id),
                  updateLikes: widget.updateLikes,
                );
              },
              itemCount: pois.length,
            ),
          ),
        ],
      ),
    );
  }
}
