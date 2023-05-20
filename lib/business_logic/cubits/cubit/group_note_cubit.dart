import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tripplanner/models/group_note_model.dart';
import 'package:tripplanner/services/firestore_services/group_notes_crud_services.dart';

part 'group_note_state.dart';

class GroupNoteCubit extends Cubit<GroupNoteState> {
  final GroupNotesCRUD groupNotesCRUD;
  late final StreamSubscription noteStream;
  //
  GroupNoteCubit(this.groupNotesCRUD) : super(GroupNoteInitial()) {
    noteStream = groupNotesCRUD.noteStream.listen((GroupNoteModel? note) {
      if (note != null) {
        emit(GroupNoteLoaded(note: note));
      }
    });
  }
}
