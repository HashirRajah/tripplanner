import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tripplanner/business_logic/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/filter_option_icon.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddNoteOptions extends StatelessWidget {
  const AddNoteOptions({super.key});
  //
  Future<void> toggleOption(BuildContext context) async {
    //
    if (BlocProvider.of<AddNoteCubit>(context).state.personal) {
      final TripsCRUD tripsCRUD =
          TripsCRUD(tripId: BlocProvider.of<TripIdCubit>(context).tripId);
      final bool isShared = await tripsCRUD.tripShared();
      //
      if (!isShared) {
        Fluttertoast.showToast(
          msg: "Trip not shared!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: green_10.withOpacity(0.5),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        //
        return;
      }
    }
    //
    if (context.mounted) {
      BlocProvider.of<AddNoteCubit>(context).toggleState();
    }
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
