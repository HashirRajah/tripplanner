import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/models/city_model.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/destination_card.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class RecommendationSection extends StatefulWidget {
  final List<int> likes;
  final Function updateLikes;
  //
  const RecommendationSection({
    super.key,
    required this.likes,
    required this.updateLikes,
  });

  @override
  State<RecommendationSection> createState() => _RecommendationSectionState();
}

class _RecommendationSectionState extends State<RecommendationSection> {
  final String title = 'Recommended for you';
  final LocalService localService = LocalService();
  List<CityModel> destinations = [];
  late final String userId;
  //
  @override
  void initState() {
    super.initState();
    //
    userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    getDestinations();
  }

  //
  Future<void> getDestinations() async {
    dynamic result = await localService.getPersonalizedDestinations(30, userId);
    //
    if (result != null) {
      setState(() {
        destinations = result;
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
            height: (spacing_8 * 38),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return DestinationCard(
                  destination: destinations[index],
                  userId: userId,
                  liked: widget.likes.contains(destinations[index].id),
                  updateLikes: widget.updateLikes,
                );
              },
              itemCount: destinations.length,
            ),
          ),
        ],
      ),
    );
  }
}
