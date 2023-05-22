import 'package:flutter/material.dart';

class FilterOption extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Function filter;
  final String tooltip;
  //
  const FilterOption({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.filter,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: IconButton(
        tooltip: tooltip,
        onPressed: () => filter(context),
        icon: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
