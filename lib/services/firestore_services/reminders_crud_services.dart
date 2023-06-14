import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripplanner/models/reminder_model.dart';
import 'package:tripplanner/services/local_notifications_services.dart';

class RemindersCRUD {
  //
  final String tripId;
  final String userId;
  final String? reminderId;
  //
  final LocalNotificationsService lnService = LocalNotificationsService();
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
    QuerySnapshot snapshot = await remindersCollection.get();
    int id = snapshot.size;
    reminder.notifId = id;
    //
    try {
      await lnService.addScheduledReminder(reminder);
      //
      await remindersCollection.add(reminder.getReminderMap()).catchError((e) {
        error = e.toString();
        //
      });
    } catch (e) {
      error = e.toString();
      print(e.toString());
    }
    //

    //
    return error;
  }

  // update reminder
  Future<String?> updateReminder(ReminderModel reminder) async {
    String? error;
    //
    if (reminderId != null) {
      //
      try {
        await lnService.deleteNotification(reminder.notifId!);
        //
        await lnService.addScheduledReminder(reminder);
        //
        await remindersCollection
            .doc(reminderId)
            .set(reminder.getReminderMap())
            .catchError((e) {
          error = e.toString();
          //
        });
      } catch (e) {
        return e.toString();
      }
      //
    }
    //
    return error;
  }

  // delete reminder
  Future<String?> deleteReminder(ReminderModel reminder) async {
    String? error;
    //
    try {
      lnService.deleteNotification(reminder.notifId!);
      //
      await remindersCollection.doc(reminderId).delete().catchError((e) {
        error = e.toString();
      });
    } catch (e) {
      error = e.toString();
    }

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
          notifId: data['notificationId'],
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
}
