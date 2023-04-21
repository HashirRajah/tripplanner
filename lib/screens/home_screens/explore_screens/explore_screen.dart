import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/services/shared_preferences_services.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPreferences prefs = SharedPreferencesService.prefs;
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await prefs.setBool('new-user', true);
        },
        child: const Text('show'),
      ),
    );
  }
}
