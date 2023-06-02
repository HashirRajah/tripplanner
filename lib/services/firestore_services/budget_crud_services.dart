import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripplanner/models/budget_model.dart';

class BudgetCRUDServices {
  //
  final String tripId;
  final String userId;
  //
  late final CollectionReference budgetCollection;
  //
  BudgetCRUDServices({required this.tripId, required this.userId}) {
    budgetCollection = FirebaseFirestore.instance
        .collection('trips')
        .doc(tripId)
        .collection('budgets');
  }
  // add budget
  Future<String?> addBudget(BudgetModel budget) async {
    String? error;
    //
    await budgetCollection
        .doc(userId)
        .set(budget.getBudgetMap())
        .catchError((e) {
      error = e.toString();
      //
    });
    //
    return error;
  }
}
