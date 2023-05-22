import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/rename_image_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class RenameImage extends StatelessWidget {
  final String filePath;
  final String newFilePath;
  //
  const RenameImage({
    super.key,
    required this.filePath,
    required this.newFilePath,
  });

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(spacing_24),
        height: getXPercentScreenHeight(60, screenHeight),
        decoration: BoxDecoration(
          color: docTileColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Text(
              'Save Image',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: green_10,
                  ),
            ),
            addVerticalSpace(spacing_24),
            RenameImageForm(
              title: 'Save',
              filePath: filePath,
              newFilePath: newFilePath,
            ),
          ],
        ),
      ),
    );
  }
}
