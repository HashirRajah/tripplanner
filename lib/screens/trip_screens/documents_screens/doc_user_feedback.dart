import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DocListFeedback extends StatelessWidget {
  final String message;
  final String svgFilePath;
  //
  const DocListFeedback({
    super.key,
    required this.message,
    required this.svgFilePath,
  });

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return Center(
      child: Column(
        children: <Widget>[
          SvgPicture.asset(
            svgFilePath,
            height: getXPercentScreenHeight(30, screenHeight),
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: green_10,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
