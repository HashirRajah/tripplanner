import 'dart:convert';
import 'package:http/http.dart';
import 'package:tripplanner/models/info_model.dart';
import 'package:tripplanner/models/visa_info_model.dart';

class TravelInfoService {
  final String authority = '192.168.202.6:8000';
  //
  Future<VisaInfoModel?> getVisaInfo(
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
        //
        List<InfoModel> requirements = [];
        for (var information in data['requirements_data']) {
          InfoModel infoModel = InfoModel(
            title: information['title'],
            content: information['content'],
          );
          //
          requirements.add(infoModel);
        }
        //
        List<InfoModel> general = [];
        for (var information in data['general_data']) {
          InfoModel infoModel = InfoModel(
            title: information['title'],
            content: information['content'],
          );
          //
          general.add(infoModel);
        }
        //
        List<InfoModel> restrictions = [];
        for (var information in data['restrictions_data']) {
          InfoModel infoModel = InfoModel(
            title: information['title'],
            content: information['content'],
          );
          //
          restrictions.add(infoModel);
        }
        //
        VisaInfoModel info = VisaInfoModel(
          url: data['url'],
          status: data['status'],
          requirements: requirements,
          general: general,
          restrictions: restrictions,
        );
        //
        return info;
      } else {
        VisaInfoModel info = VisaInfoModel(
          url: data['url'],
          status: data['status'],
          requirements: [],
          general: [],
          restrictions: [],
        );
        //
        return info;
      }
    } catch (e) {
      return null;
    }
  }
}
