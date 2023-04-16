import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tripplanner/services/shared_preferences_services.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'firebase_options.dart';
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
  // make status bar transparent
  //changeStatusBarColorToTransparent();
  // run application
  runApp(Tripplanner());
}
