import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tripplanner/services/local_notifications_services.dart';
import 'package:tripplanner/services/shared_preferences_services.dart';
import 'package:tripplanner/shared/constants/globals.dart';
import 'firebase_options.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tripplanner/services/app_dir.dart';
import 'root.dart';

Future<void> main() async {
  // ensure WidgetsFlutterBinding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // initialize shared preferences
  await SharedPreferencesService().init();
  // get initial network connection status
  initialConnectionStatus = await InternetConnectionChecker().connectionStatus;
  //
  await AppDirectoryProvider().init();
  //
  await LocalNotificationsService().initNotificationSettings();
  // run application
  runApp(Tripplanner());
}
