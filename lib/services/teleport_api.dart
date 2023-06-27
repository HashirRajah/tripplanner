import 'dart:convert';
import 'package:http/http.dart';
import 'package:tripplanner/models/category_model.dart';

class TeleportAPI {
  final String authority = 'api.teleport.org';
  //
  //
  Future<List<CategoryModel>?> getCategories() async {
    //
    const String unencodedpath = 'api/';
    //
    Uri url = Uri.https(
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
}
