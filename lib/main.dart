import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tripplanner/services/shared_preferences_services.dart';
import 'package:tripplanner/shared/constants/globals.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'firebase_options.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
  // make status bar transparent
  //changeStatusBarColorToTransparent();
  // run application
  runApp(Tripplanner());
}
