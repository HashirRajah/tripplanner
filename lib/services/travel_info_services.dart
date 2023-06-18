import 'dart:convert';

import 'package:http/http.dart';

class TravelInfoService {
  final String authority = '192.168.40.6:8000';
  //
  Future<dynamic> getVisaInfo(String residency, String destination) async {
    //
    final String unencodedpath = 'e-visa-info/$residency/$destination';
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
      return data['data'][0]['value'];
    } catch (e) {
      return null;
    }
  }
}
