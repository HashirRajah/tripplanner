import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/blocs/bloc/trip_list_bloc.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/search_textfield.dart';

class TripsSliverAppBar extends StatelessWidget {
  //
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
    return SliverAppBar(
      centerTitle: true,
      pinned: false,
      snap: true,
      floating: true,
      expandedHeight: spacing_128,
      backgroundColor: green_30,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(spacing_128),
          bottomRight: Radius.circular(spacing_128),
        ),
      ),
      title: Text(
        screenTitle,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              letterSpacing: 2.0,
              color: white_60,
              fontSize: spacing_32,
            ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(spacing_56),
        child: Padding(
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
      ),
    );
  }
}
