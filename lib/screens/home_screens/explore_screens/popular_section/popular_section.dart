import 'package:flutter/material.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/destination_card.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/more_button.dart';

class PopularSection extends StatelessWidget {
  final String title = 'Popular destinations';
  const PopularSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: green_10,
                    ),
              ),
              const MoreButton(
                navigationScreen: Placeholder(),
                routeName: '/popular-destinations',
              )
            ],
          ),
          SizedBox(
            height: (spacing_8 * 30),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const DestinationCard();
              },
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
