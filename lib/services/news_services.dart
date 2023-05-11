import 'dart:convert';

import 'package:http/http.dart';
import 'package:tripplanner/models/news_model.dart';
import 'package:tripplanner/shared/constants/api_keys.dart';

class NewsService {
  //
  final String apiKey = newsAPIKey;
  final String authority = 'newsapi.org';
  //
  Future<List<NewsModel>?> getTravelNews(String? destinations) async {
    const String unencodedpath = 'v2/everything';
    //
    String query = destinations == null
        ? 'Travel and Tourism'
        : 'travel and tourism in $destinations';
    //
    Map<String, dynamic> queryParams = {
      'apiKey': apiKey,
      'q': query,
    };
    //
    Uri url = Uri.https(
      authority,
      unencodedpath,
      queryParams,
    );
    //make request
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //debugPrint(data.toString());
      //
      if (data['status'] == 'ok' && data['totalResults'] > 0) {
        List<NewsModel> news = [];
        //
        for (Map article in data['articles']) {
          //
          news.add(NewsModel(
            title: article['title'] ?? '',
            description: article['description'] ?? '',
            url: article['url'] ?? '',
            imageUrl: article['urlToImage'] ?? '',
            publishedAt: article['publishedAt'] ?? '',
            sourceName: article['source']['name'] ?? '',
            author: article['author'] ?? '',
          ));
        }
        //
        return news;
      }
    } catch (e) {
      return null;
    }
  }
}
