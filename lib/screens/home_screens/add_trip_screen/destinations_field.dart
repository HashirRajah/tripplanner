import 'package:flutter/material.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/screens/home_screens/add_trip_screen/destinations_list.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/search_destinations.dart';

class DestinationsField extends StatefulWidget {
  final Function add;
  final Function remove;
  final List<DestinationModel> destinations;
  //
  const DestinationsField({
    super.key,
    required this.add,
    required this.remove,
    required this.destinations,
  });

  @override
  State<DestinationsField> createState() => _DestinationsFieldState();
}

class _DestinationsFieldState extends State<DestinationsField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: spacing_16,
        right: spacing_16,
        bottom: spacing_16,
      ),
      decoration: BoxDecoration(
        color: searchBarColor,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.all(0.0),
            minVerticalPadding: spacing_8,
            horizontalTitleGap: 0.0,
            // minLeadingWidth: spacing_16,
            leading: Icon(
              Icons.add_location_alt_sharp,
              color: green_10,
            ),
            title: Text(
              'Destinations',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: green_10,
              ),
            ),
            trailing: IconButton(
              onPressed: () async {
                // validate number of destinations
                if (widget.destinations.length > 19) {
                  String errorTitle = 'Limit reached';
                  String errorMessage =
                      'A maximum of 20 destinations is allowed';
                  //
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        errorSnackBar(context, errorTitle, errorMessage));
                  }
                  return;
                }
                //
                dynamic result = await showSearch(
                  context: context,
                  delegate: SearchDestinations(),
                );
                //
                if (result != null) {
                  widget.add(result);
                }
              },
              icon: Icon(
                Icons.add,
                color: green_10,
              ),
            ),
          ),
          DestinationsList(
            destinations: widget.destinations,
            remove: widget.remove,
          ),
        ],
      ),
    );
  }
}
