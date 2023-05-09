import 'package:flutter/material.dart';

class FilterOption extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  //
  const FilterOption({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
