import 'dart:convert';
import 'package:http/http.dart';
import 'package:tripplanner/models/category_model.dart';

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
  Future<String?> addUser(int uid) async {
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
      Response response = await post(url, body: {'id': uid});
      Map data = jsonDecode(response.body);
      //
      return data['status'];
    } catch (e) {
      return null;
    }
  }

  //
  Future<String?> addPreferences(int uid, List<String> prefs) async {
    //
    final String unencodedpath = 'category/';
    //
    Uri url = Uri.http(
      authority,
      unencodedpath,
    );
    //

    //make request
    try {
      Response response = await put(url, body: {
        'id': uid,
      });
      Map data = jsonDecode(response.body);
      //
      return data['status'];
    } catch (e) {
      return null;
    }
  }
}
