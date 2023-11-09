part of 'connections_bloc.dart';

abstract class ConnectionsState extends Equatable {}

class LoadingConnections extends ConnectionsState {
  @override
  List<Object?> get props => [];
}

class ConnectionsLoaded extends ConnectionsState {
  final List<UserModel> connections;

  ConnectionsLoaded({required this.connections});

  @override
  List<Object?> get props => [connections];
}

class ErrorState extends ConnectionsState {
  @override
  List<Object?> get props => [];
}
