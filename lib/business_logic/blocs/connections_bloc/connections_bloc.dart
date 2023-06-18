import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tripplanner/models/user_model.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';

part 'connections_event.dart';
part 'connections_state.dart';

class ConnectionsBloc extends Bloc<ConnectionsEvent, ConnectionsState> {
  final UsersCRUD usersCRUD;
  //
  ConnectionsBloc(this.usersCRUD) : super(LoadingConnections()) {
    on<LoadConnections>((event, emit) async {
      try {
        List<UserModel> connections = await usersCRUD.getAllConnections();
        //
        emit(ConnectionsLoaded(connections: connections));
      } catch (e) {
        emit(ErrorState());
      }
    });
  }
}
