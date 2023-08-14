import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tripplanner/models/trip_card_model.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:equatable/equatable.dart';

part 'trip_list_event.dart';
part 'trip_list_state.dart';

class TripListBloc extends Bloc<TripListEvent, TripListState> {
  //
  final TripsCRUD _tripsCRUD;
  List<TripCardModel> _cachedTrips = [];
  //
  TripListBloc(this._tripsCRUD) : super(LoadingTripList()) {
    on<LoadTripList>((event, emit) async {
      emit(LoadingTripList());
      //
      final List<TripCardModel> trips = await _tripsCRUD.loadTrips();
      // sort list by date
      trips.sort((a, b) {
        DateTime now = DateTime.now();
        //
        DateTime aEndDate = DateTime.parse(a.endDate);
        DateTime bEndDate = DateTime.parse(b.endDate);
        //
        int isAPast, isBPast;
        //
        if (!now.difference(aEndDate).isNegative) {
          isAPast = 1;
        } else {
          isAPast = 0;
        }
        //
        if (!now.difference(bEndDate).isNegative) {
          isBPast = 1;
        } else {
          isBPast = 0;
        }
        //
        Duration aDiff = DateTime.now().difference(aEndDate);
        Duration bDiff = DateTime.now().difference(bEndDate);
        //
        if (((aDiff.isNegative) && (bDiff.isNegative))) {
          aDiff *= -1;
          bDiff *= -1;
        }

        return aDiff.compareTo(bDiff);
      });
      //
      _cachedTrips = trips;
      //
      emit(TripListLoaded(trips: trips));
    });
    //
    on<SearchTripList>((event, emit) {
      //
      final List<TripCardModel> trips = event.query == ''
          ? _cachedTrips
          : _cachedTrips.where((TripCardModel trip) {
              return trip.title
                  .toLowerCase()
                  .contains(event.query.toLowerCase());
            }).toList();
      //
      emit(TripListLoaded(trips: trips));
    });
    //
  }
}
