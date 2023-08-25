import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:tripplanner/models/osm_poi_model.dart';

class OpenStreetMapAPI {
  //
  final String authority = 'overpass-api.de';
  //

  Future<List<OSMPOIModel>?> getNearbyAttractions(LatLng location) async {
    //
    const String unencodedpath = 'api/interpreter';
    const int radius = 1000;
    //
    Map<String, dynamic> queryParams = {
      'data':
          '[out:json];(node["tourism"](around:$radius,40.7128,-74.0060);relation["tourism"](around:$radius,40.7128,-74.0060););out center;'
      // 'data':
      //     '[out:json];(node["tourism"](around:$radius,${location.latitude},${location.longitude});relation["tourism"](around:$radius,${location.latitude},${location.longitude}););out center;'
    };
    //
    Uri url = Uri.http(
      authority,
      unencodedpath,
      queryParams,
    );
    //make request
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //debugPrint(data.toString());
      List<OSMPOIModel>? places;
      List<String> filters = [
        'hotel',
        'information',
      ];
      //
      if (response.statusCode == 200) {
        //
        places = [];
        //
        for (var element in data['elements']) {
          if (!filters.contains(element['tags']['tourism'])) {
            LatLng position = LatLng(
              element['lat'].toDouble(),
              element['lon'].toDouble(),
            );
            //
            String type = element['tags']['tourism'];
            //
            Map<String, dynamic> tags = element['tags'];
            //
            OSMPOIModel place = OSMPOIModel(
              position,
              type,
              tags,
            );
            //
            places.add(place);
          }
        }
      }
      return places;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
