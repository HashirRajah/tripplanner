part of 'trip_list_bloc.dart';

@immutable
abstract class TripListState extends Equatable {}

class LoadingTripList extends TripListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TripListLoaded extends TripListState {
  final List<TripCardModel> trips;
  //
  TripListLoaded({required this.trips});

  @override
  // TODO: implement props
  List<Object?> get props => [trips];
}
