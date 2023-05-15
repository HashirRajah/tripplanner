part of 'add_note_cubit.dart';

class AddNoteState extends Equatable {
  final bool personal;

  const AddNoteState({required this.personal});

  @override
  List<Object> get props => [personal];
}
