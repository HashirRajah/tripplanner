import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class VisitPOIDetailSliverAppBar extends StatefulWidget {
  final String imageLink;
  //
  const VisitPOIDetailSliverAppBar({
    super.key,
    required this.imageLink,
  });

  @override
  State<VisitPOIDetailSliverAppBar> createState() =>
      _VisitPOIDetailSliverAppBarState();
}

class _VisitPOIDetailSliverAppBarState
    extends State<VisitPOIDetailSliverAppBar> {
  //
  @override
  void initState() {
    super.initState();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  //

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
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.9),
          foregroundColor: white_60,
          child: const BackButton(),
        ),
      ),
      expandedHeight: (spacing_8 * 25),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          widget.imageLink,
          fit: BoxFit.cover,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(spacing_32),
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
