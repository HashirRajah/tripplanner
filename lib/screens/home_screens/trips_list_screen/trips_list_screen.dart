import 'package:flutter/material.dart';
import 'package:tripplanner/business_logic/blocs/trip_list_bloc/trip_list_bloc.dart';
import 'package:tripplanner/screens/home_screens/trips_list_screen/trips_list.dart';
import 'package:tripplanner/screens/home_screens/trips_list_screen/trips_sliver_app_bar.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripsListScreen extends StatefulWidget {
  const TripsListScreen({super.key});

  @override
  State<TripsListScreen> createState() => _TripsListScreenState();
}

class _TripsListScreenState extends State<TripsListScreen> {
  //
  final TextEditingController controller = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    //
    return RepositoryProvider(
      create: (context) => TripsCRUD(),
      child: BlocProvider<TripListBloc>(
        create: (context) =>
            TripListBloc(RepositoryProvider.of<TripsCRUD>(context))
              ..add(LoadTripList()),
        child: StreamBuilder<bool?>(
            stream: TripsCRUD().userDataStream,
            builder: (context, snapshot) {
              //debugPrint(snapshot.hasError.toString());
              if (snapshot.hasData) {
                BlocProvider.of<TripListBloc>(context).add(LoadTripList());
              }
              return CustomScrollView(
                slivers: [
                  TripsSliverAppBar(
                    controller: controller,
                  ),
                  const TripsList(),
                ],
              );
            }),
      ),
    );
  }
}
