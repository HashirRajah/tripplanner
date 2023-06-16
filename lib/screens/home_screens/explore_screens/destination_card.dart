import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(spacing_16),
          margin: const EdgeInsets.only(right: spacing_16),
          width: (spacing_8 * 20),
          height: (spacing_8 * 25),
          decoration: BoxDecoration(
            color: searchBarColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Text('London England'),
        ),
        Positioned(
          top: spacing_8,
          right: spacing_16,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        )
      ],
    );
  }
}
