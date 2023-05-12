import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/news_section/horizontal_news_list.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/news_section/more_news_button.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class NewsSection extends StatelessWidget {
  final String title = 'News';
  //
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spacing_8),
      height: (spacing_8 * 42),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: green_10),
              ),
              const MoreNewsButton(),
            ],
          ),
          addVerticalSpace(spacing_8),
          HorizontalNewsList(),
        ],
      ),
    );
  }
}
