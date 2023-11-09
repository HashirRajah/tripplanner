import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/models/country_info_model.dart';
import 'package:tripplanner/models/simple_news_model.dart';
import 'package:tripplanner/screens/travel_info_screens/embassy_section.dart';
import 'package:tripplanner/screens/webview_screens/webview.dart';
import 'package:tripplanner/services/country_flag_services.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/services/rest_countries_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/shared/widgets/news_card.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class NewsSection extends StatefulWidget {
  final String destination;
  //
  const NewsSection({
    super.key,
    required this.destination,
  });

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  bool dataFetched = false;
  bool newsError = false;
  List<SimpleNewsModel> news = [];
  final LocalService localService = LocalService();
  final String title = 'Related News';
  //
  @override
  void initState() {
    super.initState();
    //
    fetchNews();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  Future<void> fetchNews() async {
    //
    if (dataFetched) {
      setState(() {
        dataFetched = false;
      });
    }
    //
    dynamic result = await localService.getDestinationNews(widget.destination);
    //
    if (result == null) {
      newsError = true;
    } else {
      news = result;
    }
    //
    dataFetched = true;
    setState(() {});
  }

  //

  //
  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    if (!dataFetched || newsError) {
      return Container();
    }
    //
    return Column(
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
          ],
        ),
        SizedBox(
          height: (spacing_8 * 31),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return NewsCard(news: news[index]);
            },
            itemCount: news.length,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
