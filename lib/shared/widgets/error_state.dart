import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ErrorStateWidget extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/error.svg';
  final Function action;
  //
  const ErrorStateWidget({super.key, required this.action});

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
            'An error ocurred!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: green_10,
                  fontWeight: FontWeight.bold,
                ),
          ),
          addVerticalSpace(spacing_16),
          CircleAvatar(
            backgroundColor: green_10,
            child: IconButton(
              onPressed: () async {
                await action();
              },
              icon: const Icon(Icons.replay_outlined),
              color: white_60,
            ),
          ),
        ],
      ),
    );
  }
}
