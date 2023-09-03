import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripplanner/business_logic/cubits/additionsl_user_info_cubit/additional_user_info_cubit.dart';
import 'package:tripplanner/screens/additional_user_info_screens/additional_info.dart';
import 'package:tripplanner/screens/wrapper_screen/wrapper_screen.dart';
import 'package:tripplanner/services/firebase_messaging_service.dart';
import 'package:tripplanner/services/local_notifications_services.dart';
import 'package:tripplanner/services/shared_preferences_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  //
  final String svgFilePath = 'assets/svgs/permissions.svg';
  final String message = 'We need some permissions';
  late final String uid;
  bool check = false;
  //
  @override
  void initState() {
    super.initState();
    //
    uid = Provider.of<User?>(context, listen: false)!.uid;
  }

  //
  Future<void> navigateToAnotherRoute() async {
    final SharedPreferences preferences = SharedPreferencesService.prefs;
    //
    await preferences.setBool('user-permissions', true);
    //
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider<AdditionalUserInfoCubit>(
            create: (context) => AdditionalUserInfoCubit(),
            child: const AdditionalUserInfoScreen(),
          ),
        ),
      );
      //
      //Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  //
  Future<void> checkAndRequestPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    //
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    //
    loc.Location location = loc.Location();
    //
    bool serviceEnabled = await location.serviceEnabled();
    //
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    //
    loc.PermissionStatus locationStatus = await location.hasPermission();
    //
    if (locationStatus == PermissionStatus.denied) {
      await location.requestPermission();
    }
    //
    checkAndRequestNotificationPermissions();
  }

  //
  Future<void> checkAndRequestNotificationPermissions() async {
    final FirebaseMessagingService service = FirebaseMessagingService(uid: uid);
    //
    await service.checkPermission();
    //
    await checkAndRequestLocalNotificationPermissions();
  }

  //
  Future<void> checkAndRequestLocalNotificationPermissions() async {
    final LocalNotificationsService service = LocalNotificationsService();
    //
    await service.checkAskAndroid13Permission();
    //
    navigateToAnotherRoute();
  }

  //
  Widget buildBody() {
    if (check) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ElevatedButtonWrapper(
        childWidget: ElevatedButton(
          onPressed: () async {
            setState(() {
              check = true;
            });
            //
            await checkAndRequestPermissions();
          },
          child: const Text('Continue'),
        ),
      );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(spacing_16),
        child: Center(
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                svgFilePath,
                height: getXPercentScreenHeight(40, screenHeight),
              ),
              addVerticalSpace(spacing_16),
              Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              addVerticalSpace(spacing_64),
              buildBody(),
            ],
          ),
        ),
      ),
    );
  }
}
