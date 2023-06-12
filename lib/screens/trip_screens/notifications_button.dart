import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
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
            builder: (newContext) => BlocProvider.value(
              value: BlocProvider.of<TripIdCubit>(context),
              child: const NotificationsScreenWrapper(),
            ),
            settings: const RouteSettings(name: '/notifications'),
          ),
        );
      },
      icon: const Icon(Icons.notifications_none_outlined),
    );
  }
}
