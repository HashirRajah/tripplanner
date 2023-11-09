import 'package:flutter/material.dart';
import 'package:tripplanner/screens/home_screens/add_trip_screen/edit_trip_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EditTripScreen extends StatelessWidget {
  //
  final String screenTitle = 'Edit Trip';
  final Function reload;
  //
  const EditTripScreen({
    super.key,
    required this.reload,
  });

  @override
  Widget build(BuildContext context) {
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
                children: <Widget>[
                  EditTripForm(
                    title: 'Save',
                    reload: reload,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
