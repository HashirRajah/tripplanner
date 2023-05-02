class BudgetModel {
  int amount;
  double travelExpenses;
  double lodgingExpenses;
  double foodExpenses;
  double shoppingExpenses;
  double otherExpenses;

  BudgetModel({
    required this.amount,
    required this.travelExpenses,
    required this.lodgingExpenses,
    required this.foodExpenses,
    required this.shoppingExpenses,
    required this.otherExpenses,
  });

  Map<String, dynamic> getBudgetMap() {
    return {
      'amount': amount,
      'travelExpenses': travelExpenses,
      'lodgingExpenses': lodgingExpenses,
      'foodExpenses': foodExpenses,
      'shoppingExpenses': shoppingExpenses,
      'otherExpenses': otherExpenses,
    };
  }
}
