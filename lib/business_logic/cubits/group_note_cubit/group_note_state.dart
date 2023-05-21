part of 'group_note_cubit.dart';

abstract class GroupNoteState extends Equatable {}

class GroupNoteInitial extends GroupNoteState {
  @override
  List<Object?> get props => [];
}

class GroupNoteLoaded extends GroupNoteState {
  final GroupNoteModel note;

  GroupNoteLoaded({required this.note});

  @override
  List<Object?> get props => [note];
}
