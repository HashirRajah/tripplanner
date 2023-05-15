import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/add_notes_screen/add_note_form.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/add_notes_screen/add_note_options.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddNoteScreen extends StatelessWidget {
  //
  final String screenTitle = 'Add Note';
  final String svgFilePath = 'assets/svgs/mind.svg';
  //
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);
    Orientation screenOrientation = getScreenOrientation(context);
    //
    return Scaffold(
      backgroundColor: docTileColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(screenTitle),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(spacing_16),
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
                            : getXPercentScreenWidth(32, screenWidth),
                      ),
                      SvgPicture.asset(
                        svgFilePath,
                        height: getXPercentScreenHeight(16, screenHeight),
                      ),
                      Positioned(
                        right: spacing_8,
                        top: spacing_16,
                        child: Text(
                          'What\'s on your mind',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Positioned(
                        right: spacing_8,
                        bottom: spacing_8,
                        child: AddNoteOptions(),
                      )
                    ],
                  ),
                ),
                addVerticalSpace(spacing_8),
                const AddNoteForm(title: 'Add Note'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
