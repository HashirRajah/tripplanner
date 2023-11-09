import 'package:flutter/material.dart';
import 'package:tripplanner/models/simple_news_model.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/news_card.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TopRatedSection extends StatefulWidget {
  final String destination;
  //
  const TopRatedSection({
    super.key,
    required this.destination,
  });

  @override
  State<TopRatedSection> createState() => _TopRatedSectionState();
}

class _TopRatedSectionState extends State<TopRatedSection> {
  bool dataFetched = false;
  bool newsError = false;
  List<SimpleNewsModel> news = [];
  final LocalService localService = LocalService();
  final String title = 'Top rated places';
  late String cachedDestination;
  //
  @override
  void initState() {
    super.initState();
    //
    cachedDestination = widget.destination;
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
  List<Widget> buildBody() {
    List<Widget> body = [];
    //
    body.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style:
              Theme.of(context).textTheme.titleLarge?.copyWith(color: green_10),
        ),
      ],
    ));
    //
    if (dataFetched && !newsError) {
      body.add(SizedBox(
        height: (spacing_8 * 31),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return NewsCard(news: news[index]);
          },
          itemCount: news.length,
          scrollDirection: Axis.horizontal,
        ),
      ));
    }

    //
    return body;
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    if (cachedDestination != widget.destination) {
      cachedDestination = widget.destination;
    }
    //
    return Container(
      margin: const EdgeInsets.only(bottom: spacing_24),
      child: Column(
        children: buildBody(),
      ),
    );
  }
}
