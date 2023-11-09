part of 'share_trip_bloc.dart';

abstract class ShareTripEvent {}

class LoadConnections extends ShareTripEvent {}

class SearchConnections extends ShareTripEvent {
  final String query;

  SearchConnections({required this.query});
}
