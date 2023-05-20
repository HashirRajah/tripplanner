part of 'notes_list_bloc.dart';

abstract class NotesListState extends Equatable {}

class LoadingNotesList extends NotesListState {
  @override
  List<Object?> get props => [];
}

class PersonalNotesListLoaded extends NotesListState {
  final List<PersonalNoteModel> notes;

  PersonalNotesListLoaded({required this.notes});

  @override
  List<Object?> get props => [notes];
}

class GroupNotesListLoaded extends NotesListState {
  final List<GroupNoteModel> notes;

  GroupNotesListLoaded({required this.notes});

  @override
  List<Object?> get props => [notes];
}
