import 'package:flutter/material.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/explore_app_bar.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        ExploreSliverAppBar(),
      ],
    );
  }
}
