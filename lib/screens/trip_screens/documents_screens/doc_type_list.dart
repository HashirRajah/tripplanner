import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tripplanner/models/doc_tile_model.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/doc_screen.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/doc_tile.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DocTypeList extends StatelessWidget {
  //
  final List<DocTileModel> docTypes = [
    DocTileModel(
      title: 'Passports',
      iconData: FontAwesomeIcons.passport,
      navigationScreen: const DocScreen(
        title: 'Passports',
        path: 'passports',
      ),
    ),
    DocTileModel(
      title: 'Visas',
      iconData: Icons.file_copy_sharp,
      navigationScreen: const DocScreen(
        title: 'Visas',
        path: 'visas',
      ),
    ),
    DocTileModel(
      title: 'Travel Insurances',
      iconData: Icons.description_outlined,
      navigationScreen: const DocScreen(
        title: 'Travel Insurances',
        path: 'travel_insurances',
      ),
    ),
    DocTileModel(
      title: 'Driving Licenses',
      iconData: FontAwesomeIcons.idCard,
      navigationScreen: const DocScreen(
        title: 'Driving Licenses',
        path: 'driving_licenses',
      ),
    ),
    DocTileModel(
      title: 'Air Tickets',
      iconData: Icons.airplane_ticket,
      navigationScreen: const DocScreen(
        title: 'Air Tickets',
        path: 'air_tickets',
      ),
    ),
    DocTileModel(
      title: 'Boarding Passes',
      iconData: Icons.airline_seat_recline_extra_sharp,
      navigationScreen: const DocScreen(
        title: 'Boarding Passes',
        path: 'boarding_passes',
      ),
    ),
    DocTileModel(
      title: 'Airport Transfers',
      iconData: Icons.airport_shuttle,
      navigationScreen: const DocScreen(
        title: 'Airport Transfers',
        path: 'airport_transfers',
      ),
    ),
    DocTileModel(
      title: 'Hotel Bookings',
      iconData: FontAwesomeIcons.hotel,
      navigationScreen: const DocScreen(
        title: 'Hotel Bookings',
        path: 'hotel_bookings',
      ),
    ),
    DocTileModel(
      title: 'Car Rentals',
      iconData: FontAwesomeIcons.car,
      navigationScreen: const DocScreen(
        title: 'Car Rentals',
        path: 'car_rentals',
      ),
    ),
    DocTileModel(
      title: 'Activity Bookings',
      iconData: Icons.local_activity,
      navigationScreen: const DocScreen(
        title: 'Activity Bookings',
        path: 'activity_bookings',
      ),
    ),
    DocTileModel(
      title: 'Other',
      iconData: Icons.art_track_outlined,
      navigationScreen: const DocScreen(
        title: 'Other',
        path: 'other',
      ),
    ),
  ];
  //
  DocTypeList({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return Expanded(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(
              right: spacing_16,
              left: spacing_16,
              bottom: spacing_16,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return DocTile(
                    docTileModel: docTypes[index],
                  );
                },
                childCount: docTypes.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
