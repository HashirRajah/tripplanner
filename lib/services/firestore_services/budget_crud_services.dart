import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripplanner/models/budget_model.dart';
import 'package:tripplanner/models/expense_model.dart';
import 'package:tripplanner/services/currency_exchange_services.dart';

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

  // update budget
  Future<String?> updateBudgetAmount(int amount) async {
    String? error;
    //
    await budgetCollection.doc(userId).update({
      'budget': amount,
    }).catchError((e) {
      error = e.toString();
    });
    //
    return error;
  }

  // update budget
  Future<String?> updateBudgetCurrency(
    String baseCurrency,
    String targetCurrency,
  ) async {
    String? error;
    final CurrencyExchangeService ces = CurrencyExchangeService();
    //
    dynamic result = ces.getConvertionRate(baseCurrency, targetCurrency);
    //
    if (result != null) {
      //
      await budgetCollection.doc(userId).update({
        'currency': targetCurrency,
      }).catchError((e) {
        error = e.toString();
      });
      //
      DocumentSnapshot documentSnapshot =
          await budgetCollection.doc(userId).get();
      //
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data()! as Map<String, dynamic>;
        //
        data['budget'] = data['budget'];
        //
        for (int i = 0; i < data['air_ticket_expenses'].length; i++) {
          data['air_ticket_expenses'][i]['amount'] =
              data['air_ticket_expenses'][i]['amount'] * result;
        }
        for (int i = 0; i < data['lodging_expenses'].length; i++) {
          data['lodging_expenses'][i]['amount'] =
              data['lodging_expenses'][i]['amount'] * result;
        }
        for (int i = 0; i < data['transport_expenses'].length; i++) {
          data['transport_expenses'][i]['amount'] =
              data['transport_expenses'][i]['amount'] * result;
        }
        for (int i = 0; i < data['activity_expenses'].length; i++) {
          data['activity_expenses'][i]['amount'] =
              data['activity_expenses'][i]['amount'] * result;
        }
        for (int i = 0; i < data['other_expenses'].length; i++) {
          data['other_expenses'][i]['amount'] =
              data['other_expenses'][i]['amount'] * result;
        }
        //
        await budgetCollection.doc(userId).update(data).catchError((e) {
          error = e.toString();
        });
      }
    }
    //
    return error;
  }

  // add expense
  Future<String?> addExpense(String type, ExpenseModel expense) async {
    String? error;
    //
    await budgetCollection.doc(userId).update({
      type: FieldValue.arrayUnion([expense.getExpenseMap()])
    }).catchError((e) {
      error = e.toString();
    });

    //
    return error;
  }

  // remove expense
  Future<String?> removeExpense(int index, String type) async {
    String? error;
    //
    DocumentSnapshot documentSnapshot =
        await budgetCollection.doc(userId).get();
    //
    if (documentSnapshot.exists) {
      //
      Map<String, dynamic> data =
          documentSnapshot.data()! as Map<String, dynamic>;
      //
      data[type] = data[type].removeAt(index);
      //
      await budgetCollection.doc(userId).update(data).catchError((e) {
        error = e.toString();
      });
    } else {
      error = 'No records';
    }

    //
    return error;
  }

  //
  List<ExpenseModel> mapExpense(List<dynamic> expenses) {
    List<ExpenseModel> expensesMapped = [];
    //
    for (var value in expenses) {
      ExpenseModel expense = ExpenseModel(
        title: value['title'],
        dateAdded: value['date_added'],
        amount: value['amount'],
      );
      expensesMapped.add(expense);
    }
    //
    return expensesMapped;
  }

  // get budget
  Future<BudgetModel?> getBudget() async {
    BudgetModel? budget;
    //
    DocumentSnapshot documentSnapshot =
        await budgetCollection.doc(userId).get();
    //
    budget = getBudgetFromDocumentSnapshot(documentSnapshot);
    //
    return budget;
  }

  //
  BudgetModel? getBudgetFromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    //
    BudgetModel? budget;
    //
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data()! as Map<String, dynamic>;
      budget = BudgetModel(
        budget: data['budget'],
        currency: data['currency'],
        airTicketExpenses: mapExpense(data['air_ticket_expenses']),
        lodgingExpenses: mapExpense(data['lodging_expenses']),
        transportExpenses: mapExpense(data['transport_expenses']),
        activityExpenses: mapExpense(data['activity_expenses']),
        otherExpenses: mapExpense(data['other_expenses']),
      );
    }
    //
    return budget;
  }

  // budget stream
  Stream<BudgetModel?> get noteStream {
    return budgetCollection.doc(userId).snapshots().map(
        (DocumentSnapshot documentSnapshot) =>
            getBudgetFromDocumentSnapshot(documentSnapshot));
  }
}
