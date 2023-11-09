import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/pois_search_cubit/po_is_search_cubit.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/plan_section/poi_recommedation_screens/search_poi_section.dart';

class SearchPOIWrapper extends StatelessWidget {
  final String destination;
  final String uid;
  final List<int> likes;
  final Function updateLikes;
  //
  const SearchPOIWrapper({
    super.key,
    required this.destination,
    required this.uid,
    required this.likes,
    required this.updateLikes,
  });

  @override
  Widget build(BuildContext context) {
    //
    return SliverToBoxAdapter(
        child: BlocBuilder<PoIsSearchCubit, PoIsSearchState>(
      builder: (context, state) {
        if (state.query.length < 3) {
          return Container();
        } else {
          return SearchPOISection(
            destination: destination,
            uid: uid,
            likes: likes,
            updateLikes: updateLikes,
            query: state.query,
          );
        }
      },
    ));
  }
}
