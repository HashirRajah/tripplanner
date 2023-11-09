part of 'share_trip_bloc.dart';

abstract class ShareTripState extends Equatable {}

class LoadingConnections extends ShareTripState {
  @override
  List<Object?> get props => [];
}

class ConnectionsLoaded extends ShareTripState {
  final List<UserModel> connections;

  ConnectionsLoaded({required this.connections});

  @override
  List<Object?> get props => [connections];
}

class ErrorState extends ShareTripState {
  @override
  List<Object?> get props => [];
}
