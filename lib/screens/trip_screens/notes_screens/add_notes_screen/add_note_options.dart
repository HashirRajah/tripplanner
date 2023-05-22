import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/filter_option_icon.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddNoteOptions extends StatelessWidget {
  const AddNoteOptions({super.key});
  //
  void toggleOption(BuildContext context) {
    BlocProvider.of<AddNoteCubit>(context).toggleState();
  }

  //
  void noAction(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      height: spacing_64,
      padding: const EdgeInsets.all(spacing_8),
      decoration: BoxDecoration(
        color: searchBarColor,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: BlocBuilder<AddNoteCubit, AddNoteState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              addHorizontalSpace(spacing_8),
              FilterOption(
                icon: Icons.person_outline,
                iconColor: state.personal ? white_60 : green_10,
                backgroundColor: state.personal ? green_10 : Colors.transparent,
                filter: state.personal ? noAction : toggleOption,
                tooltip: 'Personal Note',
              ),
              addHorizontalSpace(spacing_8),
              FilterOption(
                icon: Icons.group_outlined,
                iconColor: !state.personal ? white_60 : green_10,
                backgroundColor:
                    !state.personal ? green_10 : Colors.transparent,
                filter: !state.personal ? noAction : toggleOption,
                tooltip: 'Group Note',
              ),
              addHorizontalSpace(spacing_8),
            ],
          );
        },
      ),
    );
  }
}
