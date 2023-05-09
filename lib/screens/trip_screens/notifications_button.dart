import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/notifications_wrapper.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NotificationsScreenWrapper(),
          ),
        );
      },
      icon: const Icon(Icons.notifications_none_outlined),
    );
  }
}
