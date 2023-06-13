import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/business_logic/blocs/reminders_bloc/reminders_bloc.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/search_textfield.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class RemindersSliverAppBar extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/reminder.svg';
  final String title = 'Reminders';
  //
  const RemindersSliverAppBar({super.key});
  //
  void search(BuildContext context, String query) {
    BlocProvider.of<RemindersBloc>(context).add(SearchReminders(query: query));
  }

  @override
  Widget build(BuildContext context) {
    //
    double screenWidth = getScreenWidth(context);
    //
    return SliverAppBar(
      pinned: true,
      floating: true,
      elevation: 0.0,
      expandedHeight: (spacing_8 * 34),
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
                search: search,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
