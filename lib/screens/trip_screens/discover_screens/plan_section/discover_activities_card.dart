import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DiscoverActivitiesCard extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/fun.svg';
  //
  const DiscoverActivitiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            padding: const EdgeInsets.all(spacing_16),
            height: spacing_120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: flightsCardColor,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Plan your days',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: green_10,
                      ),
                ),
                addVerticalSpace(spacing_8),
                Text(
                  'Discover the different activities',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: green_10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Hero(
            tag: 'activities',
            child: SvgPicture.asset(
              svgFilePath,
              height: (spacing_8 * 12),
            ),
          ),
          Positioned(
            left: spacing_16,
            bottom: spacing_8,
            child: CircleAvatar(
              backgroundColor: green_10,
              foregroundColor: white_60,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
