import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences prefs;
  //
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
