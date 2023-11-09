import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripplanner/models/foursquare_place_model.dart';
import 'package:tripplanner/models/visit_model.dart';
import 'package:tripplanner/screens/maps/map_relative_to_screen.dart';
import 'package:tripplanner/screens/maps/simple_map_screen.dart';
import 'package:tripplanner/screens/maps/simple_map_with_directions_screen.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class PlanFourSquareCard extends StatefulWidget {
  final FourSquarePlaceModel place;
  final DateTime startDate;
  final DateTime endDate;
  final String userId;
  final Function addVisit;
  final LatLng? relativeTo;
  //
  const PlanFourSquareCard({
    super.key,
    required this.place,
    required this.startDate,
    required this.endDate,
    required this.userId,
    required this.addVisit,
    required this.relativeTo,
  });

  @override
  State<PlanFourSquareCard> createState() => _PlanFourSquareCardState();
}

class _PlanFourSquareCardState extends State<PlanFourSquareCard> {
  final LocalService localService = LocalService();
  late UsersCRUD usersCRUD;
  bool processing = false;
  String imageLink =
      'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1121&q=80';
  //
  @override
  void initState() {
    super.initState();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: spacing_8),
      child: Stack(
        children: <Widget>[
          Card(
            elevation: 3.0,
            color: tripCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: SizedBox(
              width: (spacing_8 * 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                    child: Image.network(
                      widget.place.imageUrl,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(imageLink);
                      },
                      fit: BoxFit.cover,
                      width: (spacing_8 * 35),
                      height: (spacing_8 * 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(spacing_16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.place.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        addVerticalSpace(spacing_8),
                        Text(
                          widget.place.address,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        addVerticalSpace(spacing_16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: spacing_16,
            right: spacing_16,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: white_60,
              child: IconButton(
                onPressed: () {
                  //
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      LatLng location =
                          LatLng(widget.place.lat, widget.place.lng);
                      //
                      return MapRelativeToScreen(
                        place: location,
                        relativeTo: widget.relativeTo,
                      );
                    },
                  ));
                },
                icon: const Icon(Icons.map_outlined),
              ),
            ),
          ),
          Positioned(
            bottom: spacing_16,
            left: spacing_16,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: white_60,
              child: IconButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: widget.startDate, //get today's date
                    firstDate: widget
                        .startDate, //DateTime.now() - not to allow to choose before today.
                    lastDate: widget.endDate,
                  );
                  //
                  if (pickedDate != null) {
                    //
                    VisitModel visit = VisitModel(
                      id: widget.place.id,
                      placeId: false,
                      fsqId: true,
                      poiId: false,
                      name: widget.place.name,
                      imageUrl: widget.place.imageUrl,
                      sequence: 0,
                      lat: widget.place.lat,
                      lng: widget.place.lng,
                      additionalData: {},
                      addedBy: widget.userId,
                    );
                    //
                    setState(() {
                      processing = true;
                    });
                    await widget.addVisit(pickedDate, visit);
                    setState(() {
                      processing = false;
                    });
                  }
                },
                icon: processing
                    ? SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          color: white_60,
                          strokeWidth: 2.0,
                        ),
                      )
                    : const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
