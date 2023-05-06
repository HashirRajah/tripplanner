import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tripplanner/models/doc_tile_model.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/doc_tile.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DocTypeList extends StatelessWidget {
  //
  final List<DocTileModel> docTypes = [
    DocTileModel(
      title: 'Passports',
      iconData: FontAwesomeIcons.passport,
      navigationScreen: const Placeholder(),
    ),
    DocTileModel(
      title: 'Visas',
      iconData: Icons.file_copy_sharp,
      navigationScreen: const Placeholder(),
    ),
    DocTileModel(
      title: 'Travel Insurances',
      iconData: Icons.description_outlined,
      navigationScreen: const Placeholder(),
    ),
    DocTileModel(
      title: 'Driving Licenses',
      iconData: FontAwesomeIcons.idCard,
      navigationScreen: const Placeholder(),
    ),
    DocTileModel(
      title: 'Air Tickets',
      iconData: Icons.airplane_ticket,
      navigationScreen: const Placeholder(),
    ),
    DocTileModel(
      title: 'Hotel Bookings',
      iconData: FontAwesomeIcons.hotel,
      navigationScreen: const Placeholder(),
    ),
    DocTileModel(
      title: 'Car Rentals',
      iconData: FontAwesomeIcons.car,
      navigationScreen: const Placeholder(),
    ),
    DocTileModel(
      title: 'Activity Bookings',
      iconData: Icons.local_activity,
      navigationScreen: const Placeholder(),
    ),
    DocTileModel(
      title: 'Other',
      iconData: Icons.art_track_outlined,
      navigationScreen: const Placeholder(),
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
