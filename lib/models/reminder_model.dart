import 'package:intl/intl.dart';

class ReminderModel {
  final String? id;
  final String memo;
  final String date;
  final String time;
  int? notifId;
  //
  final DateFormat dateFormat = DateFormat('EEEE MMMM d, yyyy');
  //
  ReminderModel({
    required this.id,
    required this.memo,
    required this.date,
    required this.time,
    this.notifId,
  });
  //
  String getDateFormatted() {
    DateTime dateFormatted = DateTime.parse(date);
    //
    return dateFormat.format(dateFormatted);
  }

  //
  Map<String, dynamic> getReminderMap() {
    return {
      'memo': memo,
      'date': date,
      'time': time,
      'notificationId': notifId,
    };
  }
}
