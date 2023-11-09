import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'po_is_search_state.dart';

class PoIsSearchCubit extends Cubit<PoIsSearchState> {
  PoIsSearchCubit() : super(const PoIsSearchState(query: ''));
  //
  void search(String query) => emit(PoIsSearchState(query: query));
}
