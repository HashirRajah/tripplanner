import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class FindSliverAppBar extends StatelessWidget {
  //
  final String imageFilePath = 'assets/images/screen_images/find.jpg';
  final String title = 'Find';
  //
  const FindSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenWidth = getScreenWidth(context);
    //
    return SliverAppBar(
      pinned: true,
      elevation: 0.0,
      collapsedHeight: (spacing_8 * 10),
      systemOverlayStyle: overlayStyle,
      backgroundColor: green_10,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.9),
          foregroundColor: white_60,
          child: const BackButton(),
        ),
      ),
      expandedHeight: (spacing_8 * 20),
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
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
        ),
      ),
    );
  }
}
