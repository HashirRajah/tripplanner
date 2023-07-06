import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/plan_section/poi_recommedation_screens/poi_recommender_app_bar.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class POIRecommendationScreen extends StatelessWidget {
  const POIRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          POIRecommendationSliverAppBar(),
          SliverPadding(
            padding: EdgeInsets.all(spacing_16),
          ),
          SliverPadding(
            padding: EdgeInsets.all(spacing_16),
          ),
        ],
      ),
    );
  }
}
