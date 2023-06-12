class ReminderModel {
  final String? id;
  final String memo;
  final String date;
  final String time;
  //
  ReminderModel({
    required this.id,
    required this.memo,
    required this.date,
    required this.time,
  });

  //
  Map<String, dynamic> getReminderMap() {
    return {
      'memo': memo,
      'date': date,
      'time': time,
    };
  }
}
