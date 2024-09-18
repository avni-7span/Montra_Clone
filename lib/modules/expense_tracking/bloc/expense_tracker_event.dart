part of 'expense_tracker_bloc.dart';

abstract class ExpenseTrackerEvent extends Equatable {
  const ExpenseTrackerEvent();
}

class AddTransactionToFireStoreEvent extends ExpenseTrackerEvent {
  const AddTransactionToFireStoreEvent({required this.isExpense});

  final bool isExpense;

  @override
  List<Object?> get props => [isExpense];
}

class AmountFieldChangeEvent extends ExpenseTrackerEvent {
  const AmountFieldChangeEvent({required this.amount});

  final String amount;

  @override
  List<Object?> get props => [amount];
}

class DescriptionFieldChangeEvent extends ExpenseTrackerEvent {
  const DescriptionFieldChangeEvent({required this.description});

  final String description;

  @override
  List<Object?> get props => [description];
}

class SetCategoryEvent extends ExpenseTrackerEvent {
  const SetCategoryEvent({required this.category});
  final String? category;

  @override
  List<Object?> get props => [];
}
