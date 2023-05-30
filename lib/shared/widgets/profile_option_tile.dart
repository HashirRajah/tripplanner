import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class ProfileOptionTile extends StatelessWidget {
  final String text;
  final IconData icon;
  //
  const ProfileOptionTile({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: green_10,
      ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: green_10,
            ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_forward_outlined,
          color: green_10,
        ),
      ),
    );
  }
}
