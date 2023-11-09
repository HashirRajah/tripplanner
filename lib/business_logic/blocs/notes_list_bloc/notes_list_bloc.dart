import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tripplanner/models/group_note_model.dart';
import 'package:tripplanner/models/personal_note_model.dart';
import 'package:tripplanner/services/firestore_services/group_notes_crud_services.dart';
import 'package:tripplanner/services/firestore_services/personal_notes_crud_services.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';

part 'notes_list_event.dart';
part 'notes_list_state.dart';

class NotesListBloc extends Bloc<NotesListEvent, NotesListState> {
  //
  final PersonalNotesCRUD personalNotesCRUD;
  final GroupNotesCRUD groupNotesCRUD;
  bool personal = true;
  bool all = true;
  List<PersonalNoteModel> cachedPersonalNotes = [];
  List<GroupNoteModel> cachedGroupNotes = [];
  //
  NotesListBloc(
    this.personalNotesCRUD,
    this.groupNotesCRUD,
  ) : super(LoadingNotesList()) {
    on<LoadAllPersonalNotes>((event, emit) async {
      personal = true;
      all = true;
      //
      emit(LoadingNotesList());
      //
      final List<PersonalNoteModel> notes =
          await personalNotesCRUD.getAllNotes();
      //
      cachedPersonalNotes = notes;
      //
      emit(PersonalNotesListLoaded(notes: notes));
    });
    //
    on<LoadImportantPersonalNotes>((event, emit) async {
      personal = true;
      all = false;
      //
      emit(LoadingNotesList());
      //
      final List<PersonalNoteModel> notes =
          await personalNotesCRUD.getImportantNotes();
      //
      cachedPersonalNotes = notes;
      //
      emit(PersonalNotesListLoaded(notes: notes));
    });
    //
    on<LoadAllGroupNotes>((event, emit) async {
      //
      final TripsCRUD tripsCRUD = TripsCRUD(tripId: personalNotesCRUD.tripId);
      final bool shared = await tripsCRUD.tripShared();
      //
      personal = false;
      all = true;
      //
      emit(LoadingNotesList());
      //
      if (!shared) {
        emit(TripNotShared());
      } else {
        //
        final List<GroupNoteModel> notes = await groupNotesCRUD.geAllNotes();
        //
        cachedGroupNotes = notes;
        //
        emit(GroupNotesListLoaded(notes: notes));
      }
    });
    //
    on<LoadImportantGroupNotes>((event, emit) async {
      //
      final TripsCRUD tripsCRUD = TripsCRUD(tripId: personalNotesCRUD.tripId);
      final bool shared = await tripsCRUD.tripShared();
      //
      personal = false;
      all = false;
      //
      emit(LoadingNotesList());
      //
      if (!shared) {
        emit(TripNotShared());
      } else {
        //
        final List<GroupNoteModel> notes =
            await groupNotesCRUD.geImportantNotes();
        //
        cachedGroupNotes = notes;
        //
        emit(GroupNotesListLoaded(notes: notes));
      }
    });
    //
    on<SearchNotesList>((event, emit) {
      if (personal) {
        final List<PersonalNoteModel> notes = event.query == ''
            ? cachedPersonalNotes
            : cachedPersonalNotes.where((PersonalNoteModel note) {
                return note.title
                    .toLowerCase()
                    .contains(event.query.toLowerCase());
              }).toList();
        //
        emit(PersonalNotesListLoaded(notes: notes));
      } else {
        final List<GroupNoteModel> notes = event.query == ''
            ? cachedGroupNotes
            : cachedGroupNotes.where((GroupNoteModel note) {
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
