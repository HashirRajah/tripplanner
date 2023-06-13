import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:tripplanner/models/reminder_model.dart';

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

  // notifications details
  NotificationDetails getNotificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'main_channel',
        'Main Channel',
        channelDescription: 'Tripplanner',
        importance: Importance.max,
        priority: Priority.max,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  // init notifications settings
  Future<void> initNotificationSettings() async {
    tz.initializeTimeZones();
    //
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    //
    const DarwinInitializationSettings ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    //
    const InitializationSettings initSettings = InitializationSettings(
      android: android,
      iOS: ios,
    );
    //
    await flnPlugin.initialize(
      initSettings,
    );
  }

  // add scheduled notification
  Future addScheduledReminder(ReminderModel reminderModel) async {
    //
    List<String> times = reminderModel.time.split(':');
    TimeOfDay time =
        TimeOfDay(hour: int.parse(times[0]), minute: int.parse(times[1]));
    DateTime date = DateTime.parse(reminderModel.date);
    //
    DateTime scheduledAt = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    //

    //
    flnPlugin.zonedSchedule(
      reminderModel.notifId!,
      'Reminder',
      reminderModel.memo,
      tz.TZDateTime.from(scheduledAt, tz.local),
      getNotificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // remove notification
  Future<String?> deleteNotification(int id) async {
    String? error;
    //
    try {
      await flnPlugin.cancel(id);
    } catch (e) {
      error = e.toString();
    }
    //
    return error;
  }
}
