import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/models/news_model.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/news_section/small_news_card.dart';
import 'package:tripplanner/services/news_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class HorizontalNewsList extends StatelessWidget {
  final NewsService newsService = NewsService();
  //
  HorizontalNewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: newsService.getTravelNews(null),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          //
          if (snapshot.hasData) {
            //
            List<NewsModel> newsList = snapshot.data!;
            //
            //
            return Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SmallNewsCard(newsModel: newsList[index]);
                },
                itemCount: newsList.length > 10 ? 10 : newsList.length,
              ),
            );
          } else {
            return const Text('error');
          }
        }
      },
    );
  }
}
