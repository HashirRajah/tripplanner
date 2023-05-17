import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class PlanSection extends StatelessWidget {
  final String title = 'Plan';
  const PlanSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(spacing_16),
      margin: const EdgeInsets.only(bottom: spacing_16),
      decoration: BoxDecoration(
        color: docTileColor,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: [
          // title
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: green_10),
          ),
          addVerticalSpace(spacing_16),
          // quick navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor: green_10,
                foregroundColor: white_60,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.flight),
                ),
              ),
              CircleAvatar(
                backgroundColor: green_10,
                foregroundColor: white_60,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.hotel),
                ),
              ),
              CircleAvatar(
                backgroundColor: green_10,
                foregroundColor: white_60,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.car_rental_rounded),
                ),
              ),
              CircleAvatar(
                backgroundColor: green_10,
                foregroundColor: white_60,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.airport_shuttle),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
