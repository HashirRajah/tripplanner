import 'dart:convert';

import 'package:http/http.dart';

class TravelInfoService {
  final String authority = '192.168.100.7:8000';
  //
  Future<void> getVisaInfo() async {
    //
    const String unencodedpath = 'visa-info/MU/IN';
    //
    Map<String, dynamic> queryParams = {};
    //
    Uri url = Uri.http(
      authority,
      unencodedpath,
    );
    //

    //make request
    try {
      print('trying');
      Response response = await get(url);
      print('Here');
      Map data = jsonDecode(response.body);
      print(data.toString());
      //
    } catch (e) {
      print(e.toString());
    }
  }
}
