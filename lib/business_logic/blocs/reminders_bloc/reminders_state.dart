part of 'reminders_bloc.dart';

abstract class RemindersState extends Equatable {}

class LoadingReminders extends RemindersState {
  @override
  List<Object?> get props => [];
}

class RemindersLoaded extends RemindersState {
  final List<ReminderModel> reminders;
  //
  RemindersLoaded({required this.reminders});
  //
  @override
  List<Object?> get props => [reminders];
}

class ErrorState extends RemindersState {
  @override
  List<Object?> get props => [];
}
