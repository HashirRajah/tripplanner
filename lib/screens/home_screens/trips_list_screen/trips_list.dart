import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/models/trip_card_model.dart';
import 'package:tripplanner/models/trip_model.dart';
import 'package:tripplanner/screens/home_screens/trips_list_screen/trip_card.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:provider/provider.dart';

class TripsList extends StatelessWidget {
  final List<String> list;
  final String svgFilePath = 'assets/svgs/empty.svg';
  const TripsList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    //
    final trips = Provider.of<List<TripCardModel>>(context);
    //
    double screenHeight = getScreenHeight(context);
    //
    if (trips.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Column(
            children: <Widget>[
              addVerticalSpace(spacing_24),
              SvgPicture.asset(
                svgFilePath,
                height: getXPercentScreenHeight(30, screenHeight),
              ),
              addVerticalSpace(spacing_24),
              Text(
                'No Trips',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    } else {
      return SliverPadding(
        padding: const EdgeInsets.all(spacing_24),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return TripCard(
                trip: trips[index],
              );
            },
            childCount: trips.length,
          ),
        ),
      );
    }
  }
}
