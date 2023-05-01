import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/screens/home_screens/add_trip_screen/add_trip_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddTripScreen extends StatelessWidget {
  //
  final String screenTitle = 'Add a trip';
  final String svgFilePath = 'assets/svgs/adventure.svg';
  //
  const AddTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);
    Orientation screenOrientation = getScreenOrientation(context);
    //
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(screenTitle),
          centerTitle: true,
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
                  Center(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(
                          height: getXPercentScreenHeight(10, screenHeight),
                          width: screenOrientation == Orientation.portrait
                              ? double.infinity
                              : getXPercentScreenWidth(40, screenWidth),
                        ),
                        SvgPicture.asset(
                          svgFilePath,
                          height: getXPercentScreenHeight(20, screenHeight),
                        ),
                        Positioned(
                          right: 0,
                          bottom: spacing_8,
                          child: Text(
                            'Let the adventure begin!',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  addVerticalSpace(spacing_24),
                  const AddTripForm(title: 'Add Trip'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
