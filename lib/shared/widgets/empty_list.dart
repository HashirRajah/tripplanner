import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EmptyList extends StatelessWidget {
  final String svgFilePath;
  final String message;
  //
  const EmptyList({
    super.key,
    required this.svgFilePath,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return Center(
      child: Column(
        children: <Widget>[
          addVerticalSpace(spacing_24),
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
    ;
  }
}
