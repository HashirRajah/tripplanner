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
