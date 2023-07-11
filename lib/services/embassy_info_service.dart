import 'dart:convert';
import 'package:http/http.dart';
import 'package:tripplanner/models/embassy_info_model.dart';

class EmbassyInfoService {
  final String authority = '192.168.202.6:8000';
  //
  Future<EmbassyInfoModel?> getEmbassyInfo(
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
        //
        List<String> phoneNumbers = [];
        for (var number in data['phone_numbers']) {
          phoneNumbers.add(number);
        }
        //
        List<String> faxes = [];
        for (var fax in data['fax']) {
          faxes.add(fax);
        }
        //
        List<String> emails = [];
        for (var email in data['email']) {
          emails.add(email);
        }
        //
        EmbassyInfoModel info = EmbassyInfoModel(
          url: data['url'],
          status: data['status'],
          title: data['title'],
          address: data['address'],
          phoneNumbers: phoneNumbers,
          faxes: faxes,
          emails: emails,
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
          emails: [],
          websiteUrl: '',
        );
        //
        return info;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
