import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'trip_id_state.dart';

class TripIdCubit extends Cubit<TripIdState> {
  //
  final String tripId;
  //
  TripIdCubit(this.tripId) : super(TripIdState(tripId: tripId));
}
