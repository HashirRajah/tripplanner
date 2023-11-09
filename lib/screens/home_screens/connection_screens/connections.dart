import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/blocs/connections_bloc/connections_bloc.dart';
import 'package:tripplanner/screens/home_screens/connection_screens/connection_tile.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/empty_list.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';

class Connections extends StatefulWidget {
  const Connections({super.key});

  @override
  State<Connections> createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections> {
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
    return BlocBuilder<ConnectionsBloc, ConnectionsState>(
      builder: (context, state) {
        if (state is LoadingConnections) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        //
        if (state is ConnectionsLoaded) {
          if (state.connections.isEmpty) {
            return EmptyList(
                svgFilePath: svgFilePath, message: 'No Connections');
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacing_8),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return ConnectionTile(
                    user: state.connections[index],
                  );
                },
                itemCount: state.connections.length,
              ),
            );
          }
        }
        //
        return ErrorStateWidget(
          action: () {
            BlocProvider.of<ConnectionsBloc>(context).add(LoadConnections());
          },
        );
      },
    );
  }
}
