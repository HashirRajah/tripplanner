import 'package:flutter/material.dart';

class TripsBackButton extends StatelessWidget {
  const TripsBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.card_travel_outlined),
    );
  }
}
