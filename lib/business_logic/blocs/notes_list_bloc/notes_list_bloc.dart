import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tripplanner/models/group_note_model.dart';
import 'package:tripplanner/models/personal_note_model.dart';
import 'package:tripplanner/services/firestore_services/group_notes_crud_services.dart';
import 'package:tripplanner/services/firestore_services/personal_notes_crud_services.dart';

part 'notes_list_event.dart';
part 'notes_list_state.dart';

class NotesListBloc extends Bloc<NotesListEvent, NotesListState> {
  //
  final PersonalNotesCRUD personalNotesCRUD;
  final GroupNotesCRUD groupNotesCRUD;
  bool personal = true;
  List<PersonalNoteModel> _cachedPersonalNotes = [];
  List<GroupNoteModel> _cachedGroupNotes = [];
  //
  NotesListBloc(
    this.personalNotesCRUD,
    this.groupNotesCRUD,
  ) : super(LoadingNotesList()) {
    on<LoadAllPersonalNotes>((event, emit) async {
      personal = true;
      //
      emit(LoadingNotesList());
      //
      final List<PersonalNoteModel> notes =
          await personalNotesCRUD.getAllNotes();
      //
      _cachedPersonalNotes = notes;
      //
      emit(PersonalNotesListLoaded(notes: notes));
    });
    //
    on<LoadImportantPersonalNotes>((event, emit) async {
      personal = true;
      //
      emit(LoadingNotesList());
      //
      final List<PersonalNoteModel> notes =
          await personalNotesCRUD.getImportantNotes();
      //
      _cachedPersonalNotes = notes;
      //
      emit(PersonalNotesListLoaded(notes: notes));
    });
    //
    on<LoadAllGroupNotes>((event, emit) async {
      personal = false;
      //
      emit(LoadingNotesList());
      //
      final List<GroupNoteModel> notes = await groupNotesCRUD.geAllNotes();
      //
      _cachedGroupNotes = notes;
      //
      emit(GroupNotesListLoaded(notes: notes));
    });
    //
    on<LoadImportantGroupNotes>((event, emit) async {
      personal = false;
      //
      emit(LoadingNotesList());
      //
      final List<GroupNoteModel> notes =
          await groupNotesCRUD.geImportantNotes();
      //
      _cachedGroupNotes = notes;
      //
      emit(GroupNotesListLoaded(notes: notes));
    });
    //
    on<SearchNotesList>((event, emit) {
      if (personal) {
        final List<PersonalNoteModel> notes = event.query == ''
            ? _cachedPersonalNotes
            : _cachedPersonalNotes.where((PersonalNoteModel note) {
                return note.title
                    .toLowerCase()
                    .contains(event.query.toLowerCase());
              }).toList();
        //
        emit(PersonalNotesListLoaded(notes: notes));
      } else {
        final List<GroupNoteModel> notes = event.query == ''
            ? _cachedGroupNotes
            : _cachedGroupNotes.where((GroupNoteModel note) {
                return note.title
                    .toLowerCase()
                    .contains(event.query.toLowerCase());
              }).toList();
        //
        emit(GroupNotesListLoaded(notes: notes));
      }
    });
  }
}
