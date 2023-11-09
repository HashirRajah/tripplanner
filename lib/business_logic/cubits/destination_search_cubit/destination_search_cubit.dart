import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'destination_search_state.dart';

class DestinationSearchCubit extends Cubit<DestinationSearchState> {
  DestinationSearchCubit() : super(const DestinationSearchState(query: ''));
  //
  void search(String query) => emit(DestinationSearchState(query: query));
}
