import 'package:flutter/material.dart';
import 'package:tripplanner/models/simple_news_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final SimpleNewsModel news;
  //
  const NewsCard({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spacing_24),
      margin: const EdgeInsets.fromLTRB(0.0, spacing_8, spacing_16, spacing_8),
      width: (spacing_8 * 35),
      decoration: BoxDecoration(
        color: tripCardColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        children: <Widget>[
          Text(
            news.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          addVerticalSpace(spacing_16),
          Text(
            news.content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          addVerticalSpace(spacing_8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: green_10,
                foregroundColor: white_60,
                child: IconButton(
                  onPressed: () async {
                    //
                    Uri url = Uri.parse(news.link);
                    //
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
