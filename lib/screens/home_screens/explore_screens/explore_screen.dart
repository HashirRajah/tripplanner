import 'package:flutter/material.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // messageDialog(
          //     context, 'Signed In', 'assets/lottie_files/success.json');
        },
        child: const Text('show'),
      ),
    );
  }
}
