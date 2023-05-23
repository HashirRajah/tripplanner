import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class MoreButton extends StatelessWidget {
  final Widget navigationScreen;
  final String routeName;

  const MoreButton({
    super.key,
    required this.navigationScreen,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => navigationScreen,
            settings: RouteSettings(
              name: routeName,
            ),
          ),
        );
      },
      splashColor: searchBarColor,
      borderRadius: BorderRadius.circular(50.0),
      child: Padding(
        padding: const EdgeInsets.all(spacing_8),
        child: Text(
          'More',
          style: TextStyle(color: green_30),
        ),
      ),
    );
  }
}
