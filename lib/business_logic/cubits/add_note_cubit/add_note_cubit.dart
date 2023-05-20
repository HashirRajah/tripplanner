import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(const AddNoteState(personal: true));

  //
  void toggleState() => emit(AddNoteState(personal: !state.personal));
}
