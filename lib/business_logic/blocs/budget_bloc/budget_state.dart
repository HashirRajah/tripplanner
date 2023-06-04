part of 'budget_bloc.dart';

abstract class BudgetState extends Equatable {}

class BudgetInitial extends BudgetState {
  @override
  List<Object?> get props => [];
}

class LoadingBudget extends BudgetState {
  @override
  List<Object?> get props => [];
}

class BudgetLoaded extends BudgetState {
  final BudgetModel budget;

  BudgetLoaded({required this.budget});

  @override
  List<Object?> get props => [budget];
}

class ErrorState extends BudgetState {
  @override
  List<Object?> get props => [];
}
