import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/blocs/share_trip_bloc/share_trip_bloc.dart';
import 'package:tripplanner/screens/home_screens/share_screen/share_app_bar.dart';
import 'package:tripplanner/screens/home_screens/share_screen/share_button.dart';
import 'package:tripplanner/screens/home_screens/share_screen/share_with_list.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ShareScreen extends StatefulWidget {
  final String tripId;
  //
  const ShareScreen({
    super.key,
    required this.tripId,
  });

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  late final UsersCRUD usersCRUD;
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  //
  @override
  void initState() {
    super.initState();
    //
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    usersCRUD = UsersCRUD(uid: userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShareTripBloc>(
      create: (context) => ShareTripBloc(usersCRUD)..add(LoadConnections()),
      child: GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(spacing_24),
            child: ShareButton(
              usersCRUD: usersCRUD,
              tripId: widget.tripId,
            ),
          ),
          body: CustomScrollView(
            slivers: [
              ShareAppBar(
                controller: controller,
                focusNode: focusNode,
              ),
              const SliverPadding(
                padding: EdgeInsets.all(spacing_8),
                sliver: ShareWithList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
