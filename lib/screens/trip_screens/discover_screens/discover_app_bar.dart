import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/back.dart';
import 'package:tripplanner/screens/trip_screens/notifications_button.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DiscoverSliverAppBar extends StatelessWidget {
  //
  final String imageFilePath = 'assets/images/screen_images/discover.jpg';
  //
  const DiscoverSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenWidth = getScreenWidth(context);
    //
    return SliverAppBar(
      pinned: true,
      elevation: 0.0,
      systemOverlayStyle: darkOverlayStyle,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      foregroundColor: Theme.of(context).colorScheme.primary,
      expandedHeight: (spacing_8 * 25),
      leading: const TripsBackButton(),
      centerTitle: true,
      actions: const <Widget>[
        NotificationsButton(),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          imageFilePath,
          fit: BoxFit.cover,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(spacing_16),
        child: Container(
          height: spacing_32,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(200.0),
              topRight: Radius.circular(200.0),
            ),
          ),
        ),
      ),
    );
  }
}
