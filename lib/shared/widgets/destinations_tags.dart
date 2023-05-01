import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DestinationTag extends StatelessWidget {
  // <a href="https://www.flaticon.com/free-icons/red-flag" title="red flag icons">Red flag icons created by Freepik - Flaticon</a>
  final String defaultFlagFilePath = 'assets/images/default_images/flag.png';
  final String destination;
  final String flagUrl;
  final Function removeDestination;
  final int position;
  //
  const DestinationTag({
    super.key,
    required this.destination,
    required this.flagUrl,
    required this.removeDestination,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: spacing_8),
      padding: const EdgeInsets.all(spacing_8),
      decoration: BoxDecoration(
        color: green_10,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            radius: spacing_8,
            backgroundColor: Colors.transparent,
            child: Image.network(
              flagUrl,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset(defaultFlagFilePath),
            ),
          ),
          addHorizontalSpace(spacing_8),
          Text(
            destination,
            style: destinationsTagTextStyle,
          ),
          addHorizontalSpace(spacing_8),
          GestureDetector(
            onTap: () => removeDestination(position),
            child: Icon(
              Icons.clear_outlined,
              color: white_60,
            ),
          ),
          //addHorizontalSpace(spacing_8),
        ],
      ),
    );
  }
}
