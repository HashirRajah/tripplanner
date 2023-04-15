import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

void messageDialog(BuildContext context, String message, String lottieFilePath,
    AnimationController? controller, bool repeat) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(spacing_16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: spacing_128,
              width: spacing_128,
              child: Lottie.asset(
                lottieFilePath,
                repeat: repeat,
                controller: repeat ? null : controller,
                onLoaded: repeat
                    ? null
                    : (p0) {
                        controller?.duration = p0.duration;
                        controller?.forward();
                      },
              ),
            ),
            addVerticalSpace(spacing_8),
            Text(
              message,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    ),
  );
}
