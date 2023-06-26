import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/search_textfield.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ExploreSliverAppBar extends StatelessWidget {
  //
  final String imageFilePath = 'assets/images/screen_images/explore.jpg';
  final String title = 'Destinations';
  //
  const ExploreSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenWidth = getScreenWidth(context);
    //
    return SliverAppBar(
      pinned: true,
      elevation: 0.0,
      systemOverlayStyle: overlayStyle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(screenWidth / 2, 1),
          bottomRight: Radius.elliptical(screenWidth / 2, 1),
        ),
      ),
      title: Text(
        'Explore',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              letterSpacing: 3.0,
              fontFamily: 'Pacifico',
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              color: white_60,
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
        preferredSize: const Size.fromHeight(spacing_96),
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
            Padding(
              padding: const EdgeInsets.only(
                left: spacing_24,
                top: spacing_24,
                right: spacing_24,
              ),
              child: SearchBar(
                controller: TextEditingController(),
                focusNode: FocusNode(),
                hintText: title,
                search: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
