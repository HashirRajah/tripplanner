import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tripplanner/models/user_model.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';

part 'share_trip_event.dart';
part 'share_trip_state.dart';

class ShareTripBloc extends Bloc<ShareTripEvent, ShareTripState> {
  final UsersCRUD usersCRUD;
  List<UserModel> cachedConnections = [];
  List<String> shareWith = [];
  //
  ShareTripBloc(this.usersCRUD) : super(LoadingConnections()) {
    on<LoadConnections>((event, emit) async {
      try {
        List<UserModel> connections = await usersCRUD.getAllConnections();
        //
        cachedConnections = connections;
        //
        emit(ConnectionsLoaded(connections: connections));
      } catch (e) {
        emit(ErrorState());
      }
    });
    //
    on<SearchConnections>((event, emit) async {
      final List<UserModel> connections = event.query == ''
          ? cachedConnections
          : cachedConnections.where((UserModel user) {
              return user.username
                  .toLowerCase()
                  .contains(event.query.toLowerCase());
            }).toList();
      //
      emit(ConnectionsLoaded(connections: connections));
    });
  }

  void addShareWith(String id) => shareWith.add(id);
  //
  void removeShareWith(String id) => shareWith.remove(id);
}
