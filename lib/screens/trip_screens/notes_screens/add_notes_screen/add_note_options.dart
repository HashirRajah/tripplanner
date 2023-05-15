import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/filter_option_icon.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddNoteOptions extends StatelessWidget {
  const AddNoteOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: spacing_64,
      padding: const EdgeInsets.all(spacing_8),
      decoration: BoxDecoration(
        color: searchBarColor,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          addHorizontalSpace(spacing_8),
          FilterOption(
            icon: Icons.person_outline,
            iconColor: white_60,
            backgroundColor: green_10,
          ),
          addHorizontalSpace(spacing_8),
          FilterOption(
            icon: Icons.group_outlined,
            iconColor: green_10,
            backgroundColor: Colors.transparent,
          ),
          addHorizontalSpace(spacing_8),
        ],
      ),
    );
  }
}
