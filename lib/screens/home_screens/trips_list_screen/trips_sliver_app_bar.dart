import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/business_logic/blocs/trip_list_bloc/trip_list_bloc.dart';
import 'package:tripplanner/shared/widgets/search_textfield.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TripsSliverAppBar extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/travel.svg';
  final String screenTitle = 'Trips';
  final TextEditingController controller;
  //
  const TripsSliverAppBar({
    super.key,
    required this.controller,
  });
  //
  void search(BuildContext context, String query) {
    BlocProvider.of<TripListBloc>(context).add(SearchTripList(query: query));
  }

  //
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(screenWidth / 2, 1),
          bottomRight: Radius.elliptical(screenWidth / 2, 1),
        ),
      ),
      expandedHeight: (spacing_8 * 32),
      flexibleSpace: FlexibleSpaceBar(
        background: SvgPicture.asset(
          svgFilePath,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(spacing_96),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.bottomEnd,
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
                controller: controller,
                focusNode: FocusNode(),
                hintText: screenTitle,
                search: search,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
