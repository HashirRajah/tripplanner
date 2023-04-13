import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(spacing_24),
      child: Center(
        child: ElevatedButtonWrapper(
          childWidget: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout_outlined),
            label: const Text('Logout'),
          ),
        ),
      ),
    );
  }
}
