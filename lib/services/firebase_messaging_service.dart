import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';

class FirebaseMessagingService {
  //
  FirebaseMessaging msgInstance = FirebaseMessaging.instance;
  //
  final String? uid;
  //
  FirebaseMessagingService({required this.uid});
  //
  Future<NotificationSettings> requestPermission() async {
    NotificationSettings settings = await msgInstance.requestPermission();
    //
    return settings;
  }

  //
  Future<void> checkPermission() async {
    NotificationSettings settings = await msgInstance.getNotificationSettings();
    //
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      settings = await requestPermission();
      //
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        String? userToken = await getUserToken();
        //
        if (userToken != null) {
          final UsersCRUD usersCRUD = UsersCRUD(uid: uid!);
          //
          await usersCRUD.addToken(userToken);
        }
      }
    }
  }

  //
  Future<String?> getUserToken() async {
    String? token = await msgInstance.getToken();
    //
    return token;
  }

  //
  void sendPushNotification(String title, String content, String token) async {
    try {
      final Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');
      //
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAOUHqTlM:APA91bHxI4WTQNragR5Izn2BUzI909CJg7PNyQV2dfTtcijW9qby0OfC817hkRZZLOHObGCIUUJsVD6f-JdAlmVtdSZ_ZTFhc_ll0gf0XtXB5mRD8-MsRHpYVW3xbw1F40XYpudDMGgI',
      };
      //
      Map<String, dynamic> data = {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'status': 'done',
        'body': content,
        'title': title,
      };
      //
      Map<String, dynamic> notif = {
        'title': title,
        'body': content,
      };
      //
      Map<String, dynamic> body = {
        'priority': 'high',
        'data': data,
        'notification': notif,
        'to': token,
      };
      //
      await post(url, headers: headers, body: jsonEncode(body));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
