import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/blocs/invitations_bloc/invitations_bloc.dart';
import 'package:tripplanner/screens/home_screens/connection_screens/invitation_tile.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/empty_list.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final String svgFilePath = 'assets/svgs/invitation.svg';
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

  @override
  Widget build(BuildContext context) {
    //
    return BlocBuilder<InvitationsBloc, InvitationsState>(
      builder: (context, state) {
        if (state is LoadingInvitations) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        //
        if (state is InvitationsLoaded) {
          if (state.invitations.isEmpty) {
            return EmptyList(
                svgFilePath: svgFilePath, message: 'No Invitations');
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacing_8),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return InvitationTile(
                    user: state.invitations[index],
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.invitations.length,
              ),
            );
          }
        }
        //
        return ErrorStateWidget(
          action: () {
            BlocProvider.of<InvitationsBloc>(context).add(LoadInvitations());
          },
        );
      },
    );
  }
}
