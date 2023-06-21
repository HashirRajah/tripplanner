import 'dart:convert';
import 'package:http/http.dart';
import 'package:tripplanner/models/embassy_info_model.dart';

class EmbassyInfoService {
  final String authority = '192.168.100.7:8000';
  //
  Future<EmbassyInfoModel?> getVisaInfo(
      String residency, String destination) async {
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
        EmbassyInfoModel info = EmbassyInfoModel(
          url: data['url'],
          status: data['status'],
          title: data['title'],
          address: data['address'],
          phoneNumbers: data['phone_numbers'],
          faxes: data['faxes'],
          email: data['email'],
          websiteUrl: data['website_url'],
        );
        //
        return info;
      } else {
        EmbassyInfoModel info = EmbassyInfoModel(
          url: data['url'],
          status: data['status'],
          title: '',
          address: '',
          phoneNumbers: [],
          faxes: [],
          email: '',
          websiteUrl: '',
        );
        //
        return info;
      }
    } catch (e) {
      return null;
    }
  }
}
