import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tripplanner/models/user_model.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';

part 'invitations_event.dart';
part 'invitations_state.dart';

class InvitationsBloc extends Bloc<InvitationsEvent, InvitationsState> {
  final UsersCRUD usersCRUD;
  //
  InvitationsBloc(this.usersCRUD) : super(LoadingInvitations()) {
    on<LoadInvitations>((event, emit) async {
      try {
        List<UserModel> invitations = await usersCRUD.getAllInvitations();
        //
        emit(InvitationsLoaded(invitations: invitations));
      } catch (e) {
        emit(ErrorState());
      }
    });
  }
}
