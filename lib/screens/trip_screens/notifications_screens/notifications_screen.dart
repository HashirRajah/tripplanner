import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/notifications_screens/notifications_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        NotificationsSliverAppBar(),
      ],
    );
  }
}
