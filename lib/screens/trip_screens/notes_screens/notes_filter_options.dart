import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/blocs/notes_list_bloc/notes_list_bloc.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/filter_option_icon.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class NotesFilterOptions extends StatelessWidget {
  const NotesFilterOptions({super.key});

  //
  void loadAllPersonalNotes(BuildContext context) {
    BlocProvider.of<NotesListBloc>(context).add(LoadAllPersonalNotes());
  }

  //
  void loadImportantPersonalNotes(BuildContext context) {
    BlocProvider.of<NotesListBloc>(context).add(LoadImportantPersonalNotes());
  }

  //
  void loadAllGroupNotes(BuildContext context) {
    BlocProvider.of<NotesListBloc>(context).add(LoadAllGroupNotes());
  }

  //
  void loadImportantGroupNotes(BuildContext context) {
    BlocProvider.of<NotesListBloc>(context).add(LoadImportantGroupNotes());
  }

  //
  void noAction(BuildContext context) {}
  //
  @override
  Widget build(BuildContext context) {
    //
    bool personal;
    bool all;
    //
    return Container(
      height: spacing_64,
      padding: const EdgeInsets.all(spacing_8),
      decoration: BoxDecoration(
        color: searchBarColor,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: BlocBuilder<NotesListBloc, NotesListState>(
        builder: (context, state) {
          //
          personal = BlocProvider.of<NotesListBloc>(context).personal;
          //
          all = BlocProvider.of<NotesListBloc>(context).all;
          //
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FilterOption(
                icon: Icons.person_outline,
                iconColor: personal ? white_60 : green_10,
                backgroundColor: personal ? green_10 : Colors.transparent,
                tooltip: 'Personal',
                filter: personal
                    ? noAction
                    : (all ? loadAllPersonalNotes : loadImportantPersonalNotes),
              ),
              addHorizontalSpace(spacing_8),
              FilterOption(
                icon: Icons.group_outlined,
                iconColor: !personal ? white_60 : green_10,
                backgroundColor: !personal ? green_10 : Colors.transparent,
                tooltip: 'Group',
                filter: !personal
                    ? noAction
                    : (all ? loadAllGroupNotes : loadImportantGroupNotes),
              ),
              addHorizontalSpace(spacing_8),
              const VerticalDivider(),
              addHorizontalSpace(spacing_8),
              FilterOption(
                icon: Icons.all_inbox_outlined,
                iconColor: all ? white_60 : green_10,
                backgroundColor: all ? green_10 : Colors.transparent,
                tooltip: 'All',
                filter: all
                    ? noAction
                    : (personal ? loadAllPersonalNotes : loadAllGroupNotes),
              ),
              addHorizontalSpace(spacing_8),
              FilterOption(
                icon: Icons.star_border_outlined,
                iconColor: !all ? white_60 : green_10,
                backgroundColor: !all ? green_10 : Colors.transparent,
                tooltip: 'Important',
                filter: !all
                    ? noAction
                    : (personal
                        ? loadImportantPersonalNotes
                        : loadImportantGroupNotes),
              ),
            ],
          );
        },
      ),
    );
  }
}
