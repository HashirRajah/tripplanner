part of 'reminders_bloc.dart';

abstract class RemindersEvent {}

class LoadReminders extends RemindersEvent {}

class SearchReminders extends RemindersEvent {
  final String query;

  SearchReminders({required this.query});
}
