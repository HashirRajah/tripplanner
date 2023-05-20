import 'package:flutter/material.dart';
import 'package:tripplanner/models/news_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class SmallNewsCard extends StatelessWidget {
  //
  final NewsModel newsModel;
  final String imageFilePath = 'assets/images/screen_images/article.jpg';
  //
  const SmallNewsCard({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: spacing_8),
      child: Stack(
        children: <Widget>[
          Card(
            elevation: 3.0,
            color: tripCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: SizedBox(
              width: (spacing_8 * 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                    ),
                    child: Image.network(
                      newsModel.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(spacing_16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          newsModel.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        addVerticalSpace(spacing_24),
                        Text(
                          newsModel.sourceName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: spacing_16,
            right: spacing_16,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
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
