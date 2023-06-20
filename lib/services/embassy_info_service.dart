import 'dart:convert';
import 'package:http/http.dart';

class EmbassyInfoService {
  final String authority = '192.168.100.7:8000';
  //
  Future<dynamic> getVisaInfo(String residency, String destination) async {
    //
    final String unencodedpath = 'embassy-info/$residency/$destination';
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
