import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tripplanner/models/reminder_model.dart';
import 'package:tripplanner/services/firestore_services/reminders_crud_services.dart';
part 'reminders_event.dart';
part 'reminders_state.dart';

class RemindersBloc extends Bloc<RemindersEvent, RemindersState> {
  //
  final RemindersCRUD _remindersCRUD;
  List<ReminderModel> cachedReminders = [];
  //
  RemindersBloc(this._remindersCRUD) : super(LoadingReminders()) {
    on<LoadReminders>((event, emit) async {
      emit(LoadingReminders());
      //
      try {
        final List<ReminderModel> reminders =
            await _remindersCRUD.getAllReminders();
        cachedReminders = reminders;
        //
        emit(RemindersLoaded(reminders: reminders));
      } catch (e) {
        emit(ErrorState());
      }
    });
    //
    on<SearchReminders>((event, emit) {
      final List<ReminderModel> reminders = event.query == ''
          ? cachedReminders
          : cachedReminders.where((ReminderModel reminder) {
              return reminder.memo
                  .toLowerCase()
                  .contains(event.query.toLowerCase());
            }).toList();
      //
      emit(RemindersLoaded(reminders: reminders));
    });
  }
}
