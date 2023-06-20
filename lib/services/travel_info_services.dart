import 'dart:convert';

import 'package:http/http.dart';

class TravelInfoService {
  final String authority = '192.168.100.7:8000';
  //
  Future<dynamic> getVisaInfo(
      String citizenship, String residency, String destination) async {
    //
    final String unencodedpath =
        'visa-info/$citizenship/$residency/$destination';
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
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
