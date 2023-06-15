import 'dart:convert';

import 'package:http/http.dart';

class TravelInfoService {
  final String authority = '192.168.100.7:8000';
  //
  Future<void> getVisaInfo(String residency, String destination) async {
    //
    final String unencodedpath = 'visa-info/$residency/$destination';
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
    } catch (e) {}
  }
}
