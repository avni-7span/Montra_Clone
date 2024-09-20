part of 'expense_tracker_bloc.dart';

enum ExpenseTrackerStateStatus {
  initial,
  loading,
  deleteDataLoading,
  updateLoading,
  failure,
  success,
  deleted,
  updated,
}

class ExpenseTrackerState extends Equatable {
  const ExpenseTrackerState({
    this.status = ExpenseTrackerStateStatus.initial,
    this.transactionAmount = const EmptyFieldValidator.pure(),
    this.description = const EmptyFieldValidator.pure(),
    this.category,
    this.isValid = false,
    this.errorMessage,
  });

  final ExpenseTrackerStateStatus status;
  final EmptyFieldValidator transactionAmount;
  final EmptyFieldValidator description;
  final String? category;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        status,
        transactionAmount,
        description,
        category,
        isValid,
        errorMessage,
      ];

  ExpenseTrackerState copyWith({
    ExpenseTrackerStateStatus? status,
    EmptyFieldValidator? transactionAmount,
    EmptyFieldValidator? description,
    String? category,
    bool? isValid,
    String? errorMessage,
  }) {
    return ExpenseTrackerState(
      status: status ?? this.status,
      transactionAmount: transactionAmount ?? this.transactionAmount,
      description: description ?? this.description,
      category: category ?? this.category,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
