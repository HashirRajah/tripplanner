import 'package:tripplanner/models/expense_model.dart';

class BudgetModel {
  final int budget;
  final String currency;
  final List<ExpenseModel> airTicketExpenses;
  final List<ExpenseModel> lodgingExpenses;
  final List<ExpenseModel> transportExpenses;
  final List<ExpenseModel> activityExpenses;
  final List<ExpenseModel> otherExpenses;

  BudgetModel({
    required this.budget,
    required this.currency,
    required this.airTicketExpenses,
    required this.lodgingExpenses,
    required this.transportExpenses,
    required this.activityExpenses,
    required this.otherExpenses,
  });

  Map<String, dynamic> getBudgetMap() {
    return {
      'budget': budget,
      'currency': currency,
      'air_ticket_expenses': airTicketExpenses,
      'lodging_expenses': lodgingExpenses,
      'transport_expenses': transportExpenses,
      'activity_expenses': activityExpenses,
      'other_expenses': otherExpenses,
    };
  }
}
