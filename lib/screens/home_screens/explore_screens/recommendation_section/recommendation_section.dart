import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/more_button.dart';

class RecommendationSection extends StatelessWidget {
  final String title = 'Recommended for you';
  const RecommendationSection({super.key});

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
                routeName: '/recommended-destinations',
              )
            ],
          ),
        ],
      ),
    );
  }
}
