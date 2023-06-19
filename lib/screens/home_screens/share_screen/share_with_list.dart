import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/blocs/share_trip_bloc/share_trip_bloc.dart';
import 'package:tripplanner/screens/home_screens/share_screen/share_with_tile.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/empty_sliver_list.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/shared/widgets/loading_sliver_list.dart';

class ShareWithList extends StatefulWidget {
  const ShareWithList({super.key});

  @override
  State<ShareWithList> createState() => _ShareWithListState();
}

class _ShareWithListState extends State<ShareWithList> {
  //
  final String svgFilePath = 'assets/svgs/freinds.svg';
  //
  @override
  void initState() {
    super.initState();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShareTripBloc, ShareTripState>(
      builder: (context, state) {
        if (state is LoadingConnections) {
          return const LoadingSliverList();
        }
        //
        if (state is ConnectionsLoaded) {
          if (state.connections.isEmpty) {
            return EmptySliverList(
                svgFilePath: svgFilePath, message: 'No Connections');
          } else {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ShareWithTile(
                    user: state.connections[index],
                  );
                },
                childCount: state.connections.length,
              ),
            );
          }
        }
        //
        return SliverToBoxAdapter(
          child: ErrorStateWidget(
            action: () {
              BlocProvider.of<ShareTripBloc>(context).add(LoadConnections());
            },
          ),
        );
      },
    );
  }
}
