part of 'po_is_search_cubit.dart';

class PoIsSearchState extends Equatable {
  final String query;

  const PoIsSearchState({required this.query});

  @override
  List<Object> get props => [query];
}
