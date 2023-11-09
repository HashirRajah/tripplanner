part of 'destination_search_cubit.dart';

class DestinationSearchState extends Equatable {
  final String query;

  const DestinationSearchState({required this.query});

  @override
  List<Object> get props => [query];
}
