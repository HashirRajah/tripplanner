import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tripplanner/business_logic/cubits/page_index_cubit/page_index_cubit.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class BottomGNav extends StatelessWidget {
  //
  final List<GButton> tabs;
  //
  const BottomGNav({
    super.key,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spacing_16),
      decoration: shadow(Theme.of(context).scaffoldBackgroundColor, 0.0, 0.0),
      child: GNav(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        tabBackgroundColor: Theme.of(context).colorScheme.primary,
        activeColor: white_60,
        padding: const EdgeInsets.all(spacing_16),
        gap: spacing_8,
        tabs: tabs,
        onTabChange: (value) =>
            BlocProvider.of<PageIndexCubit>(context).changePageIndex(value),
      ),
    );
  }
}
