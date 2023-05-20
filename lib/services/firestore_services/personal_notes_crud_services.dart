import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripplanner/models/personal_note_model.dart';

class PersonalNotesCRUD {
  //
  final String tripId;
  final String userId;
  final String? noteId;
  //
  late final CollectionReference notesCollection;
  //
  PersonalNotesCRUD({required this.tripId, required this.userId, this.noteId}) {
    notesCollection = FirebaseFirestore.instance
        .collection('trips')
        .doc(tripId)
        .collection('personal_notes_$userId');
  }

  // add note
  Future<String?> addNote(PersonalNoteModel note) async {
    String? error;
    //
    await notesCollection.add(note.getPersonalNoteMap()).catchError((e) {
      error = e.toString();
      //
    });
    //
    return error;
  }

  // update note
  Future<String?> updateNote(
    String title,
    String body,
    String modifiedAt,
  ) async {
    String? error;
    //
    if (noteId != null) {
      await notesCollection.doc(noteId).update({
        'title': title,
        'body': body,
        'modified_at': modifiedAt,
      }).catchError((e) {
        error = e.toString();
      });
    }
    //
    return error;
  }

  // delete note
  Future<String?> deleteNote() async {
    String? error;
    //
    await notesCollection.doc(noteId).delete().catchError((e) {
      error = e.toString();
    });
    //
    return error;
  }

  // star / unstar note
  Future<String?> starUnstarNote(bool important) async {
    String? error;
    //
    if (noteId != null) {
      notesCollection
          .doc(noteId)
          .update({'important': important}).catchError((e) {
        error = e.toString();
      });
    }
    //
    return error;
  }

  // get all notes
  Future<List<PersonalNoteModel>> getAllNotes() async {
    List<PersonalNoteModel> notes = [];
    //
    QuerySnapshot querySnapshot = await notesCollection.get();
    //
    for (var doc in querySnapshot.docs) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        //
        PersonalNoteModel note = PersonalNoteModel(
          noteId: doc.id,
          title: data['title'],
          body: data['body'],
          important: data['important'],
          modifiedAt: data['modified_at'],
        );
        //
        notes.add(note);
      }
    }
    //
    return notes;
  }

  // get important notes
  Future<List<PersonalNoteModel>> getImportantNotes() async {
    List<PersonalNoteModel> notes = [];
    //
    QuerySnapshot querySnapshot =
        await notesCollection.where('important', isEqualTo: true).get();
    //
    for (var doc in querySnapshot.docs) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        //
        PersonalNoteModel note = PersonalNoteModel(
          noteId: doc.id,
          title: data['title'],
          body: data['body'],
          important: data['important'],
          modifiedAt: data['modified_at'],
        );
        //
        notes.add(note);
      }
    }
    //
    return notes;
  }

  // personal notes stream
  Stream<int> get personalNotesStream {
    return notesCollection.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.size;
    });
  }

  PersonalNoteModel? getNoteFromDocumentSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      //
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      //
      return PersonalNoteModel(
        noteId: noteId,
        title: data['title'],
        body: data['body'],
        important: data['important'],
        modifiedAt: data['modified_at'],
      );
    } else {
      return null;
    }
  }

  // single note doc stream
  Stream<PersonalNoteModel?> get noteStream {
    return notesCollection.doc(noteId).snapshots().map(
        (DocumentSnapshot documentSnapshot) =>
            getNoteFromDocumentSnapshot(documentSnapshot));
  }
}
