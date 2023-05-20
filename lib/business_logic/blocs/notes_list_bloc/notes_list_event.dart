part of 'notes_list_bloc.dart';

abstract class NotesListEvent {}

class LoadAllPersonalNotes extends NotesListEvent {}

class LoadImportantPersonalNotes extends NotesListEvent {}

class LoadAllGroupNotes extends NotesListEvent {}

class LoadImportantGroupNotes extends NotesListEvent {}

class SearchNotesList extends NotesListEvent {
  final String query;

  SearchNotesList({required this.query});
}
