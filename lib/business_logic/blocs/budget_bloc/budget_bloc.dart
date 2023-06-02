import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tripplanner/models/budget_model.dart';
import 'package:tripplanner/services/firestore_services/budget_crud_services.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final BudgetCRUDServices budgetCRUDServices;
  //
  BudgetBloc(this.budgetCRUDServices) : super(BudgetInitial()) {
    on<LoadBudget>((event, emit) async {
      emit(LoadingBudget());
      //
      try {
        BudgetModel? budget = await budgetCRUDServices.getBudget();
        //
        if (budget != null) {
          emit(BudgetLoaded(budget: budget));
        } else {
          emit(ErrorState());
        }
      } catch (e) {
        print(e.toString());
        emit(ErrorState());
      }
    });
  }
}
