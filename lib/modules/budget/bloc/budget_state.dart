part of 'budget_bloc.dart';

enum BudgetStateStatus {
  initial,
  loading,
  success,
  failure,
  deletedSuccessfully,
  updatedSuccessfully
}

class BudgetState extends Equatable {
  const BudgetState({
    this.status = BudgetStateStatus.initial,
    this.shouldReceiveAlert = false,
    this.category,
    this.sliderValue = 20,
    this.amount = const EmptyFieldValidator.pure(),
    this.isValid = false,
    this.errorMessage = '',
    this.budgetDataModelList = const [],
    this.categoryList = const [],
    this.spentAmountMap = const {},
  });

  final BudgetStateStatus status;
  final bool shouldReceiveAlert;
  final String? category;
  final double? sliderValue;
  final EmptyFieldValidator amount;
  final bool isValid;
  final String errorMessage;
  final List<BudgetDataModel> budgetDataModelList;
  final List<String> categoryList;
  final Map<String, double> spentAmountMap;

  @override
  List<Object?> get props => [
        status,
        shouldReceiveAlert,
        category,
        sliderValue,
        amount,
        isValid,
        errorMessage,
        budgetDataModelList,
        categoryList,
        spentAmountMap,
      ];

  BudgetState copyWith({
    BudgetStateStatus? status,
    bool? shouldReceiveAlert,
    String? category,
    double? sliderValue,
    EmptyFieldValidator? amount,
    bool? isValid,
    String? errorMessage,
    List<BudgetDataModel>? budgetDataModelList,
    List<String>? categoryList,
    Map<String, double>? spentAmountMap,
  }) {
    return BudgetState(
      status: status ?? this.status,
      shouldReceiveAlert: shouldReceiveAlert ?? this.shouldReceiveAlert,
      category: category ?? this.category,
      sliderValue: sliderValue ?? this.sliderValue,
      amount: amount ?? this.amount,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      budgetDataModelList: budgetDataModelList ?? this.budgetDataModelList,
      categoryList: categoryList ?? this.categoryList,
      spentAmountMap: spentAmountMap ?? this.spentAmountMap,
    );
  }
}
