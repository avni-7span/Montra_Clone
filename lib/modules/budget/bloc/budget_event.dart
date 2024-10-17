part of 'budget_bloc.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();
}

class SetCategoryEvent extends BudgetEvent {
  const SetCategoryEvent({
    required this.category,
  });

  final String? category;

  @override
  List<Object?> get props => [category];
}

class ReceiveAlertSwitchChangeEvent extends BudgetEvent {
  const ReceiveAlertSwitchChangeEvent({required this.shouldReceiveAlert});
  final bool shouldReceiveAlert;

  @override
  List<Object?> get props => [shouldReceiveAlert];
}

class SliderChangeEvent extends BudgetEvent {
  const SliderChangeEvent({required this.sliderValue});
  final double? sliderValue;

  @override
  List<Object?> get props => [sliderValue];
}

class ContinueButtonTapEvent extends BudgetEvent {
  @override
  List<Object?> get props => [];
}

class AmountTextFieldChangeEvent extends BudgetEvent {
  const AmountTextFieldChangeEvent({required this.amount});
  final String amount;
  @override
  List<Object?> get props => [amount];
}

class LoadBudgetDataFromFireStoreEvent extends BudgetEvent {
  @override
  List<Object?> get props => [];
}

class LoadCategoryList extends BudgetEvent {
  @override
  List<Object?> get props => [];
}

class DeleteBudgetEvent extends BudgetEvent {
  const DeleteBudgetEvent({required this.budgetID});
  final String budgetID;

  @override
  List<Object?> get props => [budgetID];
}

class UpdateBudgetEvent extends BudgetEvent {
  const UpdateBudgetEvent({
    required this.budgetID,
    required this.budgetAmount,
  });
  final String budgetID;
  final double budgetAmount;
  @override
  List<Object?> get props => [budgetID, budgetID];
}
