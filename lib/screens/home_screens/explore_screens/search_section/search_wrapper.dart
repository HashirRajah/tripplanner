import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/destination_search_cubit/destination_search_cubit.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/search_section/search_section.dart';

class SearchWrapper extends StatelessWidget {
  final List<int> likes;
  final Function updateLikes;
  //
  const SearchWrapper({
    super.key,
    required this.likes,
    required this.updateLikes,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: BlocBuilder<DestinationSearchCubit, DestinationSearchState>(
      builder: (context, state) {
        if (state.query.length < 3) {
          return Container();
        } else {
          return SearchSection(
            likes: likes,
            updateLikes: updateLikes,
            query: state.query,
          );
        }
      },
    ));
  }
}
