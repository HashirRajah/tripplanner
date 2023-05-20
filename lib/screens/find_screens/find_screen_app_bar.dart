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
      systemOverlayStyle: darkOverlayStyle,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              letterSpacing: 3.0,
              fontFamily: 'Pacifico',
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              color: green_10,
            ),
      ),
      centerTitle: true,
      expandedHeight: (spacing_8 * 30),
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
