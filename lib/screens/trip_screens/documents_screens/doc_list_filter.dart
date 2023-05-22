import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/doc_list_cubit/doc_list_cubit.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/filter_option_icon.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DocListOptions extends StatelessWidget {
  const DocListOptions({super.key});
  //
  void toggleOption(BuildContext context) {
    BlocProvider.of<DocListCubit>(context).toggleState();
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
      child: BlocBuilder<DocListCubit, DocListState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              addHorizontalSpace(spacing_8),
              FilterOption(
                icon: Icons.folder_shared,
                iconColor: state.shared ? white_60 : green_10,
                backgroundColor: state.shared ? green_10 : Colors.transparent,
                filter: state.shared ? noAction : toggleOption,
                tooltip: 'General',
              ),
              addHorizontalSpace(spacing_8),
              FilterOption(
                icon: Icons.card_travel,
                iconColor: !state.shared ? white_60 : green_10,
                backgroundColor: !state.shared ? green_10 : Colors.transparent,
                filter: !state.shared ? noAction : toggleOption,
                tooltip: 'Trip Specific',
              ),
              addHorizontalSpace(spacing_8),
            ],
          );
        },
      ),
    );
  }
}
