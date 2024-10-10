import 'package:equatable/equatable.dart';

class BudgetCardModel extends Equatable {
  const BudgetCardModel({
    required this.category,
    required this.spentAmount,
    required this.budgetAmount,
  });

  final String category;
  final double spentAmount;
  final double budgetAmount;

  @override
  List<Object?> get props => [
        category,
        spentAmount,
        budgetAmount,
      ];
}
