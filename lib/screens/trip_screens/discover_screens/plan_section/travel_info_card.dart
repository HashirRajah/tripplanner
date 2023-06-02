import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/screens/travel_info_screens/travel_info_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TravelInfoCard extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/investigate.svg';
  //
  const TravelInfoCard({super.key});

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
              color: carRentalsCardColor,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Travel Information',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: green_10,
                      ),
                ),
                addVerticalSpace(spacing_8),
                Text(
                  'Find visa information for your trip',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: green_10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Hero(
            tag: 'travel-info',
            child: SvgPicture.asset(
              svgFilePath,
              height: (spacing_8 * 11),
            ),
          ),
          Positioned(
            left: spacing_16,
            bottom: spacing_8,
            child: CircleAvatar(
              backgroundColor: green_10,
              foregroundColor: white_60,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TravelInfoScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
