import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/cubits/root_cubit/root_cubit.dart';
import 'package:tripplanner/screens/wrapper_screen/wrapper_screen.dart';
import 'shared/constants/theme_constants.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Tripplanner extends StatelessWidget {
  //
  final _auth = FirebaseAuth.instance;
  final InternetConnectionChecker _internetConnectionChecker =
      InternetConnectionChecker();
  //
  Tripplanner({super.key});
  //
  final String title = 'Tripplanner';
  //
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RootCubit>.value(
      value: RootCubit(),
      child: MultiProvider(
        providers: [
          StreamProvider<User?>.value(
            value: _auth.userChanges(),
            initialData: _auth.currentUser,
          ),
          StreamProvider<InternetConnectionStatus?>.value(
            value: _internetConnectionChecker.onStatusChange,
            initialData: null,
          ),
        ],
        child: MaterialApp(
          title: title,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: BlocBuilder<RootCubit, RootState>(
            builder: (context, state) {
              return WrapperScreen();
            },
          ),
        ),
      ),
    );
  }
}
