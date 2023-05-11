import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/screens/trip_screens/back.dart';
import 'package:tripplanner/screens/trip_screens/notifications_button.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/search_textfield.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class NotesSliverAppBar extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/notes.svg';
  final String title = 'Notes';
  //
  const NotesSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenWidth = getScreenWidth(context);
    //
    return SliverAppBar(
      pinned: true,
      floating: true,
      elevation: 0.0,
      systemOverlayStyle: overlayStyle,
      expandedHeight: (spacing_8 * 32),
      leading: const TripsBackButton(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(screenWidth / 2, 1),
          bottomRight: Radius.elliptical(screenWidth / 2, 1),
        ),
      ),
      actions: <Widget>[
        const NotificationsButton(),
        Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu_outlined),
            );
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: SvgPicture.asset(svgFilePath),
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
