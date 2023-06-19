import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tripplanner/business_logic/blocs/share_trip_bloc/share_trip_bloc.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';

class ShareButton extends StatefulWidget {
  final UsersCRUD usersCRUD;
  final String tripId;
  //
  const ShareButton({
    super.key,
    required this.usersCRUD,
    required this.tripId,
  });

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton>
    with SingleTickerProviderStateMixin {
  //
  //
  final String successMessage = 'Trip Shared';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.popUntil(context, (route) => route.isFirst);
        controller.reset();
      }
    });
  }

  //
  @override
  void dispose() {
    //
    controller.dispose();
    //
    super.dispose();
  }

  //
  Future<void> share() async {
    if (BlocProvider.of<ShareTripBloc>(context).shareWith.isEmpty) {
      Fluttertoast.showToast(
        msg: "No connections selected!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: green_10.withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      dynamic result = await widget.usersCRUD.shareTrip(
        BlocProvider.of<ShareTripBloc>(context).shareWith,
        widget.tripId,
      );
      //
      if (result != null) {
        Fluttertoast.showToast(
          msg: "$result!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: green_10.withOpacity(0.5),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        if (context.mounted) {
          messageDialog(context, successMessage, successLottieFilePath,
              controller, false);
        }
      }
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return ElevatedButtonWrapper(
      childWidget: ElevatedButton.icon(
        onPressed: () async {
          await share();
        },
        icon: const Icon(Icons.share_outlined),
        label: const Text('Share'),
      ),
    );
  }
}
