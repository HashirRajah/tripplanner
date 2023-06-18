import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/screens/travel_info_screens/travel_info_app_bar.dart';
import 'package:tripplanner/screens/travel_info_screens/travel_info_tabs.dart';
import 'package:tripplanner/screens/webview_screens/webview.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/services/travel_info_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class TravelInfoScreen extends StatefulWidget {
  const TravelInfoScreen({super.key});

  @override
  State<TravelInfoScreen> createState() => _TravelInfoScreenState();
}

class _TravelInfoScreenState extends State<TravelInfoScreen> {
  late TripsCRUD tripsCRUD;
  List<DestinationModel> destinations = [];
  //
  @override
  void initState() {
    super.initState();
    //
    tripsCRUD = TripsCRUD(tripId: BlocProvider.of<TripIdCubit>(context).tripId);
    loadDestinations();
  }

  //
  Future<void> loadDestinations() async {
    List<DestinationModel> dest = await tripsCRUD.getAllDestinations();
    //
    setState(() {
      destinations = dest;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: destinations.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, spacing_104),
          child: TravelInfoAppBar(
            destinations: destinations,
          ),
        ),
        body: TravelInfoTabs(
          destinations: destinations,
        ),
      ),
    );
  }
}
