import 'package:flutter/material.dart';
import 'package:tripplanner/models/simple_news_model.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/news_card.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class BlogsSection extends StatefulWidget {
  final String destination;
  //
  const BlogsSection({
    super.key,
    required this.destination,
  });

  @override
  State<BlogsSection> createState() => _BlogsSectionState();
}

class _BlogsSectionState extends State<BlogsSection> {
  bool dataFetched = false;
  bool newsError = false;
  List<SimpleNewsModel> news = [];
  final LocalService localService = LocalService();
  final String title = 'Travel Blogs';
  late String cachedDestination;
  //
  @override
  void initState() {
    super.initState();
    //
    cachedDestination = widget.destination;
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
    if (cachedDestination != widget.destination) {
      fetchNews();
      cachedDestination = widget.destination;
    }
    //
    double screenHeight = getScreenHeight(context);
    //
    if (!dataFetched || newsError) {
      return Container();
    }
    //
    return Container(
      margin: const EdgeInsets.only(bottom: spacing_24),
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
      ),
    );
  }
}
