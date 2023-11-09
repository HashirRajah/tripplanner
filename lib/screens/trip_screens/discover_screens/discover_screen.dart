import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/currency_exchnage_section/currency_exchange_section.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/discover_app_bar.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/news_section/news_section.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/plan_section/plan_section.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/trip_details_section/trip_details_section.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return CustomScrollView(
      slivers: <Widget>[
        const DiscoverSliverAppBar(),
        SliverPadding(
          padding: const EdgeInsets.all(spacing_16),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: const <Widget>[
                TripDetailsSection(),
                PlanSection(),
                CurrencyExchangeSection(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
