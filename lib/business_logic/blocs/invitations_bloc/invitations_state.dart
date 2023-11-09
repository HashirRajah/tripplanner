part of 'invitations_bloc.dart';

abstract class InvitationsState extends Equatable {}

class LoadingInvitations extends InvitationsState {
  @override
  List<Object?> get props => [];
}

class InvitationsLoaded extends InvitationsState {
  final List<UserModel> invitations;

  InvitationsLoaded({required this.invitations});

  @override
  List<Object?> get props => [invitations];
}

class ErrorState extends InvitationsState {
  @override
  List<Object?> get props => [];
}
