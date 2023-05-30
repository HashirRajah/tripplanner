import 'package:flutter/material.dart';
import 'package:tripplanner/screens/home_screens/profile_screen/options.dart';
import 'package:tripplanner/screens/home_screens/profile_screen/profile.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/services/auth_services.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(spacing_16),
        child: Column(
          children: <Widget>[
            const Profile(),
            addVerticalSpace(spacing_48),
            const ProfileOptions(),
          ],
        ),
      ),
    );
  }
}
