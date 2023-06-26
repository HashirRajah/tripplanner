import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/cubits/add_preferences_cubit/add_preferences_cubit.dart';
import 'package:tripplanner/screens/auth_navigation_screen/auth_navigation_screen.dart';
import 'package:tripplanner/screens/email_verification_screen/email_verification_screen.dart';
import 'package:tripplanner/screens/home_screens/home.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tripplanner/screens/network_error_screen/network_error_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripplanner/screens/onboarding_screens/onboarding_screen.dart';
import 'package:tripplanner/screens/preferences_screens/add_preferences_screen.dart';
import 'package:tripplanner/services/shared_preferences_services.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key});
  //

  @override
  Widget build(BuildContext context) {
    //
    final SharedPreferences prefs = SharedPreferencesService.prefs;
    // new user
    final bool? newUser = prefs.getBool('new-user');
    //
    // preferences chosen
    final bool? prefsChoosen = prefs.getBool('user-prefs');
    //
    final User? user = Provider.of<User?>(context);
    debugPrint(user?.displayName);
    // to check internet connection
    final InternetConnectionStatus? connectionStatus =
        Provider.of<InternetConnectionStatus?>(context);
    // if new user show onboarding screen
    if (newUser == true || newUser == null) {
      return OnboardingScreen();
    }
    // user not logged in
    if (user == null) {
      if (connectionStatus == InternetConnectionStatus.connected) {
        return const AuthNavigationScreen();
      }
      //
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
      //
      return const NetworkErrorScreen();
    }
    // if user did not verify email
    final bool verifiedUser = user.emailVerified;
    //
    if (!verifiedUser) {
      return const EmailVerificationScreen();
    }
    //
    if (prefsChoosen == false || prefsChoosen == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider<AddPreferencesCubit>(
                create: (context) => AddPreferencesCubit(),
                child: const AddPreferencesScreen(),
              );
            },
          ),
        );
      });
    }
    //
    return Home();
  }
}
