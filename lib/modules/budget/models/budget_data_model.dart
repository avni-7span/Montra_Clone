import 'package:equatable/equatable.dart';

class BudgetDataModel extends Equatable {
  const BudgetDataModel({
    required this.createdAt,
    required this.category,
    required this.budgetAmount,
    required this.budgetId,
    required this.alertLimit,
    required this.shouldReceiveAlert,
  });

  final int createdAt;
  final String category;
  final double budgetAmount;
  final String budgetId;
  final double? alertLimit;
  final bool shouldReceiveAlert;

  @override
  List<Object?> get props => [
        createdAt,
        category,
        budgetAmount,
        budgetId,
        alertLimit,
        shouldReceiveAlert,
      ];
}
