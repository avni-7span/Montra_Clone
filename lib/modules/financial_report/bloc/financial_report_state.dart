part of 'financial_report_bloc.dart';

enum FinancialReportStateStatus { initial, success, failure, loading }

class FinancialReportState extends Equatable {
  const FinancialReportState(
      {this.currentIndex = 0,
      this.status = FinancialReportStateStatus.initial,
      this.highestExpense = '0',
      this.highestIncome = '0',
      this.totalIncome = '0',
      this.totalExpense = '0',
      this.expenseCategory = 'Expense',
      this.incomeCategory = 'Income'});

  final FinancialReportStateStatus status;
  final int currentIndex;
  final String totalIncome;
  final String totalExpense;
  final String incomeCategory;
  final String expenseCategory;
  final String highestIncome;
  final String highestExpense;

  @override
  List<Object?> get props => [
        currentIndex,
        totalExpense,
        totalIncome,
        incomeCategory,
        expenseCategory,
        highestExpense,
        highestIncome,
      ];

  FinancialReportState copyWith({
    FinancialReportStateStatus? status,
    int? currentIndex,
    String? totalIncome,
    String? totalExpense,
    String? incomeCategory,
    String? expenseCategory,
    String? highestIncome,
    String? highestExpense,
  }) {
    return FinancialReportState(
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      incomeCategory: incomeCategory ?? this.incomeCategory,
      expenseCategory: expenseCategory ?? this.expenseCategory,
      highestIncome: highestIncome ?? this.highestIncome,
      highestExpense: highestExpense ?? this.highestExpense,
    );
  }
}
