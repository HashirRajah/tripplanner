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
      navigationScreen: DocScreen(title: 'Passports'),
    ),
    DocTileModel(
      title: 'Visas',
      iconData: Icons.file_copy_sharp,
      navigationScreen: DocScreen(title: 'Visas'),
    ),
    DocTileModel(
      title: 'Travel Insurances',
      iconData: Icons.description_outlined,
      navigationScreen: DocScreen(title: 'Travel Insurances'),
    ),
    DocTileModel(
      title: 'Driving Licenses',
      iconData: FontAwesomeIcons.idCard,
      navigationScreen: DocScreen(title: 'Driving Licenses'),
    ),
    DocTileModel(
      title: 'Air Tickets',
      iconData: Icons.airplane_ticket,
      navigationScreen: DocScreen(title: 'Air Tickets'),
    ),
    DocTileModel(
      title: 'Airport Transfers',
      iconData: Icons.airport_shuttle,
      navigationScreen: DocScreen(title: 'Airport Transfers'),
    ),
    DocTileModel(
      title: 'Hotel Bookings',
      iconData: FontAwesomeIcons.hotel,
      navigationScreen: DocScreen(title: 'Hotel Bookings'),
    ),
    DocTileModel(
      title: 'Car Rentals',
      iconData: FontAwesomeIcons.car,
      navigationScreen: DocScreen(title: 'Car Rentals'),
    ),
    DocTileModel(
      title: 'Activity Bookings',
      iconData: Icons.local_activity,
      navigationScreen: DocScreen(title: 'Activity Bookings'),
    ),
    DocTileModel(
      title: 'Other',
      iconData: Icons.art_track_outlined,
      navigationScreen: DocScreen(title: 'Other'),
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
