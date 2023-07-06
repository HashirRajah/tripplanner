import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:tripplanner/models/category_model.dart';
import 'package:tripplanner/models/city_boundary_model.dart';
import 'package:tripplanner/models/city_model.dart';
import 'package:tripplanner/models/simple_news_model.dart';

class LocalService {
  final String authority = '192.168.100.7:8000';
  //
  //
  Future<List<CategoryModel>?> getCategories() async {
    //
    const String unencodedpath = 'categories';
    //
    Uri url = Uri.http(
      authority,
      unencodedpath,
    );
    //

    //make request
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //
      List<CategoryModel>? categories;
      //
      if (data['status'] == 'ok') {
        categories = [];
        //
        for (Map category in data['categories']) {
          CategoryModel cat = CategoryModel(
            id: category['id'],
            title: category['name'],
            url: category['image_url'],
          );
          categories.add(cat);
        }
      }
      //
      return categories;
    } catch (e) {
      return null;
    }
  }

  //
  Future<CategoryModel?> getCategory(int id) async {
    //
    final String unencodedpath = 'category/$id';
    //
    Uri url = Uri.http(
      authority,
      unencodedpath,
    );
    //

    //make request
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //
      CategoryModel? category;
      //
      if (data['status'] == 'ok') {
        category = CategoryModel(
          id: data['id'],
          title: data['name'],
          url: data['image_url'],
        );
      }
      //
      return category;
    } catch (e) {
      return null;
    }
  }

  //
  //
  Future<String?> addUser(String uid) async {
    //
    final String unencodedpath = 'add/user';
    //
    Uri url = Uri.http(
      authority,
      unencodedpath,
    );
    //

    //make request
    try {
      Response response = await post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': uid}),
      );
      Map data = jsonDecode(response.body);
      //
      return data['status'];
    } catch (e) {
      return null;
    }
  }

  //
  Future<String?> addPreferences(String uid, List<String> prefs) async {
    //
    final String unencodedpath = 'update/add-preferences';
    //
    Uri url = Uri.http(
      authority,
      unencodedpath,
    );
    //
    //make request
    try {
      Response response = await put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"id": uid, "preferences": prefs}),
      );
      Map data = jsonDecode(response.body);
      //
      return data['status'];
    } catch (e) {
      return null;
    }
  }

  //
  Future<List<SimpleNewsModel>?> getDestinationNews(String destination) async {
    //
    final String unencodedpath = 'news/dest/$destination';
    //
    Uri url = Uri.http(
      authority,
      unencodedpath,
    );
    //
    //make request
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //
      if (data['status'] == 'ok') {
        List<SimpleNewsModel> news = [];
        //
        for (Map n in data['articles']) {
          SimpleNewsModel newsModel = SimpleNewsModel(
            title: n['title'],
            content: n['content'],
            link: n['link'],
          );
          //
          news.add(newsModel);
        }
        //
        return news;
      } else {
        return null;
      }
      //
    } catch (e) {
      return null;
    }
  }

  Future<List<CityModel>?> getPopularDestination(int k) async {
    //
    final String unencodedpath = 'recommendations/popular/dest/$k';
    //
    Uri url = Uri.http(
      authority,
      unencodedpath,
    );
    //
    //make request
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //
      if (data['status'] == 'ok') {
        List<CityModel> cities = [];
        //
        for (Map city in data['recommendations']) {
          CityModel cityModel = CityModel(
            id: city['id'],
            name: city['name'],
            country: city['country'],
            likes: city['likes'],
            views: city['views'],
          );
          //
          cities.add(cityModel);
        }
        //
        return cities;
      } else {
        return null;
      }
      //
    } catch (e) {
      return null;
    }
  }

  //
  Future<CityBoundaryModel?> getCityBoundary(String city) async {
    //
    final String unencodedpath = '/city-boundary/$city';
    //
    Uri url = Uri.http(
      authority,
      unencodedpath,
    );
    //
    //make request
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //
      if (data['status'] == 'ok') {
        List<LatLng> boundary = [];
        LatLng cityLatLng = LatLng(
          double.parse(data['city_lat_lng'][0]),
          double.parse(data['city_lat_lng'][1]),
        );
        //
        for (var point in data['boundary']) {
          //print('${point[0]}, ${point[1]}');
          LatLng latLng = LatLng(point[1].toDouble(), point[0].toDouble());
          // print(latLng);
          //
          boundary.add(latLng);
          //print('after');
        }
        //
        CityBoundaryModel cityBoundaryModel = CityBoundaryModel(
          cityLatLng: cityLatLng,
          boundary: boundary,
        );
        //
        return cityBoundaryModel;
      } else {
        return null;
      }
      //
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }
}
