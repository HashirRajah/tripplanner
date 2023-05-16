import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripplanner/models/group_note_model.dart';

class GroupNotesCRUD {
  //
  final String tripId;
  final String userId;
  final String? noteId;
  //
  late final CollectionReference notesCollection;
  //
  GroupNotesCRUD({required this.tripId, required this.userId, this.noteId}) {
    notesCollection = FirebaseFirestore.instance
        .collection('trips')
        .doc(tripId)
        .collection('group_notes');
  }

  // add note
  Future<String?> addNote(GroupNoteModel note) async {
    String? error;
    //
    await notesCollection.add(note.getGroupNoteMap()).catchError((e) {
      error = e.toString();
      //
    });
    //
    return error;
  }

  // update note
  Future<String?> updateNote(GroupNoteModel note) async {
    String? error;
    //
    if (noteId != null) {
      await notesCollection
          .doc(noteId)
          .set(note.getGroupNoteMap())
          .catchError((e) {
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
      notesCollection.doc(noteId).update({
        'stared_by': important
            ? FieldValue.arrayUnion([userId])
            : FieldValue.arrayRemove([userId])
      }).catchError((e) {
        error = e.toString();
      });
    }
    //
    return error;
  }

  // get all notes
  Future<List<GroupNoteModel>> geAllNotes() async {
    List<GroupNoteModel> notes = [];
    //
    QuerySnapshot querySnapshot = await notesCollection.get();
    //
    for (var doc in querySnapshot.docs) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        //
        GroupNoteModel note = GroupNoteModel(
          noteId: doc.id,
          title: data['title'],
          body: data['body'],
          modifiedAt: data['modified_at'],
          owner: data['owner'],
          staredBy: data['stared_by'],
        );
        //
        notes.add(note);
      }
    }
    //
    return notes;
  }

  // get important notes
  Future<List<GroupNoteModel>> geImportantNotes() async {
    List<GroupNoteModel> notes = [];
    //
    QuerySnapshot querySnapshot =
        await notesCollection.where('stared_by', arrayContains: userId).get();
    //
    for (var doc in querySnapshot.docs) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        //
        GroupNoteModel note = GroupNoteModel(
          noteId: doc.id,
          title: data['title'],
          body: data['body'],
          modifiedAt: data['modified_at'],
          owner: data['owner'],
          staredBy: data['stared_by'],
        );
        //
        notes.add(note);
      }
    }
    //
    return notes;
  }

  // personal notes stream
  Stream<int> get groupNotesStream {
    return notesCollection.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.size;
    });
  }

  GroupNoteModel? getNoteFromDocumentSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      //
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      //
      return GroupNoteModel(
        noteId: noteId,
        title: data['title'],
        body: data['body'],
        owner: data['owner'],
        modifiedAt: data['modified_at'],
        staredBy: data['stared_by'],
      );
    } else {
      return null;
    }
  }

  // single note stream
  Stream<GroupNoteModel?> get noteStream {
    return notesCollection.doc(noteId).snapshots().map(
        (DocumentSnapshot documentSnapshot) =>
            getNoteFromDocumentSnapshot(documentSnapshot));
  }
}
