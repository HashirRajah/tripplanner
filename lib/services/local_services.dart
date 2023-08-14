import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:tripplanner/models/category_model.dart';
import 'package:tripplanner/models/city_boundary_model.dart';
import 'package:tripplanner/models/city_model.dart';
import 'package:tripplanner/models/poi_model.dart';
import 'package:tripplanner/models/simple_news_model.dart';
import 'package:tripplanner/shared/constants/server_conf.dart';

class LocalService {
  final String authority = '$serverIP:8000';
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
    const String unencodedpath = 'add/user';
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
    const String unencodedpath = 'update/add-preferences';
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
  Future<String?> addDestinationView(String uid, int destinationId) async {
    //
    const String unencodedpath = 'add/destinations/views';
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
        body: jsonEncode({"user_id": uid, "item_id": destinationId}),
      );
      Map data = jsonDecode(response.body);
      //
      return data['status'];
    } catch (e) {
      return null;
    }
  }

  //
  Future<String?> addDestinationLike(String uid, int destinationId) async {
    //
    const String unencodedpath = 'add/destinations/likes';
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
        body: jsonEncode({"user_id": uid, "item_id": destinationId}),
      );
      Map data = jsonDecode(response.body);
      //
      return data['status'];
    } catch (e) {
      return null;
    }
  }

  //
  Future<String?> removeDestinationLike(String uid, int destinationId) async {
    //
    const String unencodedpath = 'remove/destinations/likes';
    //
    Uri url = Uri.http(
      authority,
      unencodedpath,
    );
    //
    //make request
    try {
      Response response = await delete(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"user_id": uid, "item_id": destinationId}),
      );
      Map data = jsonDecode(response.body);
      //
      return data['status'];
    } catch (e) {
      return null;
    }
  }

  //
  Future<String?> addPOIView(String uid, int poiId) async {
    //
    const String unencodedpath = 'add/pois/views';
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
        body: jsonEncode({"user_id": uid, "item_id": poiId}),
      );
      Map data = jsonDecode(response.body);
      //
      return data['status'];
    } catch (e) {
      return null;
    }
  }

  //
  Future<String?> addPOIlLike(String uid, int poiId) async {
    //
    const String unencodedpath = 'add/pois/likes';
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
        body: jsonEncode({"user_id": uid, "item_id": poiId}),
      );
      Map data = jsonDecode(response.body);
      //
      return data['status'];
    } catch (e) {
      return null;
    }
  }

  //
  //
  Future<String?> removePOIlLike(String uid, int poiId) async {
    //
    const String unencodedpath = 'remove/pois/likes';
    //
    Uri url = Uri.http(
      authority,
      unencodedpath,
    );
    //
    //make request
    try {
      Response response = await delete(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"user_id": uid, "item_id": poiId}),
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
  Future<List<CityModel>?> getPersonalizedDestinations(
      int k, String uid) async {
    //
    final String unencodedpath = 'recommendations/personalized/dest/$uid/$k';
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

  //
  Future<List<POIModel>?> getPopularPOIs(int k, String destination) async {
    //
    final String unencodedpath = 'recommendations/popular/poi/$k/$destination';
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
        List<POIModel> pois = [];
        //
        for (Map poi in data['recommendations']) {
          //
          POIModel poiModel = POIModel(
            id: poi['id'],
            name: poi['name'],
            description: poi['description'],
            image: poi['image_url'],
            distance: poi['distance'],
            likes: poi['likes'],
            views: poi['views'],
            lat: poi['lat'],
            lng: poi['lng'],
          );
          //
          pois.add(poiModel);
        }
        //
        return pois;
      } else {
        return null;
      }
      //
    } catch (e) {
      return null;
    }
  }

  //
  //
  Future<POIModel?> getPOIDetails(int id) async {
    //
    final String unencodedpath = 'poi/details/$id';
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
        //
        POIModel poiModel = POIModel(
          id: data['details']['id'],
          name: data['details']['name'],
          description: data['details']['description'],
          image: data['details']['image_url'],
          distance: data['details']['distance'],
          likes: data['details']['likes'],
          views: data['details']['views'],
          lat: data['details']['lat'],
          lng: data['details']['lng'],
        );
        //
        return poiModel;
      } else {
        return null;
      }
      //
    } catch (e) {
      return null;
    }
  }

  //
  Future<List<POIModel>?> getPOIsForDestination(String destination) async {
    //
    final String unencodedpath = 'poi/$destination';
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
        List<POIModel> pois = [];
        //
        for (Map poi in data['pois']) {
          //
          POIModel poiModel = POIModel(
            id: poi['id'],
            name: poi['name'],
            description: poi['description'],
            image: poi['image_url'],
            distance: poi['distance'],
            likes: poi['likes'],
            views: poi['views'],
            lat: poi['lat'],
            lng: poi['lng'],
          );
          //
          pois.add(poiModel);
        }
        //
        return pois;
      } else {
        return null;
      }
      //
    } catch (e) {
      return null;
    }
  }

  //
  Future<List<POIModel>?> getPersonalizedPOIs(
      String uid, int k, String destination) async {
    //
    final String unencodedpath =
        'recommendations/personalized/poi/$uid/$k/$destination';
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
        List<POIModel> pois = [];
        //
        for (Map poi in data['recommendations']) {
          //
          POIModel poiModel = POIModel(
            id: poi['id'],
            name: poi['name'],
            description: poi['description'],
            image: poi['image_url'],
            distance: poi['distance'],
            likes: poi['likes'],
            views: poi['views'],
            lat: poi['lat'],
            lng: poi['lng'],
          );
          //
          pois.add(poiModel);
        }
        //
        return pois;
      } else {
        return null;
      }
      //
    } catch (e) {
      return null;
    }
  }
}
