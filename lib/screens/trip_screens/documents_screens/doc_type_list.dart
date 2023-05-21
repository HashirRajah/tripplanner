import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tripplanner/business_logic/cubits/doc_list_cubit/doc_list_cubit.dart';
import 'package:tripplanner/models/doc_tile_model.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/doc_screen.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/doc_tile.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class DocTypeList extends StatelessWidget {
  //
  final List<DocTileModel> sharedDocs = [
    DocTileModel(
      title: 'Passports',
      iconData: FontAwesomeIcons.passport,
      navigationScreen: const DocScreen(
        title: 'Passports',
        shared: true,
        path: 'passports',
      ),
    ),
    DocTileModel(
      title: 'Driving Licenses',
      iconData: FontAwesomeIcons.idCard,
      navigationScreen: const DocScreen(
        title: 'Driving Licenses',
        shared: true,
        path: 'driving_licenses',
      ),
    ),
  ];
  //
  final List<DocTileModel> docTypes = [
    DocTileModel(
      title: 'Visas',
      iconData: Icons.file_copy_sharp,
      navigationScreen: const DocScreen(
        title: 'Visas',
        shared: false,
        path: 'visas',
      ),
    ),
    DocTileModel(
      title: 'Travel Insurances',
      iconData: Icons.description_outlined,
      navigationScreen: const DocScreen(
        title: 'Travel Insurances',
        shared: false,
        path: 'travel_insurances',
      ),
    ),
    DocTileModel(
      title: 'Air Tickets',
      iconData: Icons.airplane_ticket,
      navigationScreen: const DocScreen(
        title: 'Air Tickets',
        shared: false,
        path: 'air_tickets',
      ),
    ),
    DocTileModel(
      title: 'Boarding Passes',
      iconData: Icons.airline_seat_recline_extra_sharp,
      navigationScreen: const DocScreen(
        title: 'Boarding Passes',
        shared: false,
        path: 'boarding_passes',
      ),
    ),
    DocTileModel(
      title: 'Airport Transfers',
      iconData: Icons.airport_shuttle,
      navigationScreen: const DocScreen(
        title: 'Airport Transfers',
        shared: false,
        path: 'airport_transfers',
      ),
    ),
    DocTileModel(
      title: 'Hotel Bookings',
      iconData: FontAwesomeIcons.hotel,
      navigationScreen: const DocScreen(
        title: 'Hotel Bookings',
        shared: false,
        path: 'hotel_bookings',
      ),
    ),
    DocTileModel(
      title: 'Car Rentals',
      iconData: FontAwesomeIcons.car,
      navigationScreen: const DocScreen(
        title: 'Car Rentals',
        shared: false,
        path: 'car_rentals',
      ),
    ),
    DocTileModel(
      title: 'Activity Bookings',
      iconData: Icons.local_activity,
      navigationScreen: const DocScreen(
        title: 'Activity Bookings',
        shared: false,
        path: 'activity_bookings',
      ),
    ),
    DocTileModel(
      title: 'Other',
      iconData: Icons.art_track_outlined,
      navigationScreen: const DocScreen(
        title: 'Other',
        shared: false,
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
            sliver: BlocBuilder<DocListCubit, DocListState>(
              builder: (context, state) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return DocTile(
                        docTileModel:
                            state.shared ? sharedDocs[index] : docTypes[index],
                      );
                    },
                    childCount:
                        state.shared ? sharedDocs.length : docTypes.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
