import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/add_reminder_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class NotificationsSliverAppBar extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/notif.svg';
  //
  const NotificationsSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenWidth = getScreenWidth(context);
    //
    return SliverAppBar(
      pinned: true,
      floating: true,
      elevation: 0.0,
      expandedHeight: (spacing_8 * 32),
      systemOverlayStyle: overlayStyle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(screenWidth / 2, 1),
          bottomRight: Radius.elliptical(screenWidth / 2, 1),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(child: SvgPicture.asset(svgFilePath)),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(spacing_88),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: spacing_32,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
