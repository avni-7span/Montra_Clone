import 'package:equatable/equatable.dart';

class BudgetDataModel extends Equatable {
  const BudgetDataModel({
    required this.createdAt,
    required this.category,
    required this.budgetAmount,
    required this.budgetId,
    required this.alertLimit,
  });

  final int createdAt;
  final String category;
  final double budgetAmount;
  final String budgetId;
  final double? alertLimit;

  @override
  List<Object?> get props => [
        createdAt,
        category,
        budgetAmount,
        budgetId,
        alertLimit,
      ];
}
