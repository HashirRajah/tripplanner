import 'package:flutter/material.dart';

class BudgetBackButton extends StatelessWidget {
  final Function action;
  //
  const BudgetBackButton({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        action();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }
}
