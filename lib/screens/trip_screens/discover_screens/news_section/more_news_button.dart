import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/news_section/news_list_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class MoreNewsButton extends StatelessWidget {
  const MoreNewsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NewsListScreen(),
          ),
        );
      },
      splashColor: searchBarColor,
      borderRadius: BorderRadius.circular(50.0),
      child: Padding(
        padding: const EdgeInsets.all(spacing_8),
        child: Text(
          'More',
          style: TextStyle(color: green_30),
        ),
      ),
    );
  }
}
