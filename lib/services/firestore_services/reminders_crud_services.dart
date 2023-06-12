import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripplanner/models/reminder_model.dart';

class RemindersCRUD {
  //
  final String tripId;
  final String userId;
  final String? reminderId;
  //
  late final CollectionReference remindersCollection;
  //
  RemindersCRUD({required this.tripId, required this.userId, this.reminderId}) {
    remindersCollection = FirebaseFirestore.instance
        .collection('trips')
        .doc(tripId)
        .collection('reminders_$userId');
  }

  // add reminder
  Future<String?> addReminder(ReminderModel reminder) async {
    String? error;
    //
    await remindersCollection.add(reminder.getReminderMap()).catchError((e) {
      error = e.toString();
      //
    });
    //
    return error;
  }

  // update reminder
  Future<String?> updateReminder(
    String title,
    String body,
    String modifiedAt,
  ) async {
    String? error;
    //
    if (reminderId != null) {
      await remindersCollection.doc(reminderId).update({
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

  // delete reminder
  Future<String?> deleteReminder() async {
    String? error;
    //
    await remindersCollection.doc(reminderId).delete().catchError((e) {
      error = e.toString();
    });
    //
    return error;
  }

  // get all reminders
  Future<List<ReminderModel>> getAllReminders() async {
    List<ReminderModel> reminders = [];
    //
    QuerySnapshot querySnapshot = await remindersCollection.get();
    //
    for (var doc in querySnapshot.docs) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        //
        ReminderModel reminder = ReminderModel(
          id: doc.id,
          memo: data['memo'],
          date: data['date'],
          time: data['time'],
        );
        //
        reminders.add(reminder);
      }
    }
    //
    return reminders;
  }

  // reminders stream
  Stream<int> get remindersStream {
    return remindersCollection.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.size;
    });
  }

  ReminderModel? getReminderFromDocumentSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      //
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      //
      return ReminderModel(
        id: snapshot.id,
        memo: data['memo'],
        date: data['date'],
        time: data['time'],
      );
    } else {
      return null;
    }
  }

  // single reminder doc stream
  Stream<ReminderModel?> get reminderStream {
    return remindersCollection.doc(reminderId).snapshots().map(
        (DocumentSnapshot documentSnapshot) =>
            getReminderFromDocumentSnapshot(documentSnapshot));
  }
}
