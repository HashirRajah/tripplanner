import 'package:intl/intl.dart';

class ExpenseModel {
  final String title;
  final String dateAdded;
  final double amount;
  //
  final DateFormat dateFormat = DateFormat('EEEE MMMM d, yyyy H:m');

  ExpenseModel({
    required this.title,
    required this.dateAdded,
    required this.amount,
  });

  //
  String getDateAddedFormatted() {
    DateTime dateAddedFormatted = DateTime.parse(dateAdded);
    //
    return dateFormat.format(dateAddedFormatted);
  }

  Map<String, dynamic> getExpenseMap() {
    return {
      'title': title,
      'date_added': dateAdded,
      'amount': amount,
    };
  }
}
