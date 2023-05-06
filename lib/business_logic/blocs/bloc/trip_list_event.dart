part of 'trip_list_bloc.dart';

@immutable
abstract class TripListEvent {}

class LoadTripList extends TripListEvent {}

class SearchTripList extends TripListEvent {
  final String query;

  SearchTripList({required this.query});
}
