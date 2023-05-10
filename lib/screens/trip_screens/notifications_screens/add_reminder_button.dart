import 'package:flutter/material.dart';

class AddReminderButton extends StatelessWidget {
  const AddReminderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add_alert_outlined),
    );
  }
}
