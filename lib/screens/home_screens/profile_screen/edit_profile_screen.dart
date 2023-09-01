import 'package:flutter/material.dart';
import 'package:tripplanner/screens/home_screens/profile_screen/edit_profile_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EditProfileScreen extends StatelessWidget {
  //
  final String screenTitle = 'Edit Profile';
  //
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //
    Orientation screenOrientation = getScreenOrientation(context);
    //
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(screenTitle),
          centerTitle: true,
          systemOverlayStyle: overlayStyle,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(spacing_24),
            child: Center(
              child: Column(
                crossAxisAlignment: screenOrientation == Orientation.portrait
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: const <Widget>[
                  EditProfileForm(title: 'Save'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
