import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService {
  final FlutterLocalNotificationsPlugin flnPlugin =
      FlutterLocalNotificationsPlugin();
  // check android permissions
  Future<bool?> checkAskAndroid13Permission() async {
    return await flnPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
  }
  // add scheduled notification

  // remove notification
}
