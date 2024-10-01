part of 'financial_analysis_bloc.dart';

enum AnalysisFilter { income, expense }

enum FinancialAnalysisStateStatus { initial, failure, success, loading }

class FinancialAnalysisState extends Equatable {
  const FinancialAnalysisState({
    this.status = FinancialAnalysisStateStatus.initial,
    this.isAnalysisBudgetType = true,
    this.filterType = AnalysisFilter.expense,
    this.transactionList = const [],
    this.totalAmount = 0,
    this.chartDataList = const [],
  });

  final bool isAnalysisBudgetType;
  final FinancialAnalysisStateStatus status;
  final AnalysisFilter filterType;
  final List<TransactionModel> transactionList;
  final double totalAmount;
  final List<ChartDataModel> chartDataList;

  @override
  List<Object?> get props => [
        isAnalysisBudgetType,
        status,
        filterType,
        transactionList,
        totalAmount,
        chartDataList,
      ];

  FinancialAnalysisState copyWith({
    bool? isAnalysisBudgetType,
    FinancialAnalysisStateStatus? status,
    AnalysisFilter? filterType,
    List<TransactionModel>? transactionList,
    double? totalAmount,
    List<ChartDataModel>? chartDataList,
  }) {
    return FinancialAnalysisState(
      isAnalysisBudgetType: isAnalysisBudgetType ?? this.isAnalysisBudgetType,
      status: status ?? this.status,
      filterType: filterType ?? this.filterType,
      transactionList: transactionList ?? this.transactionList,
      totalAmount: totalAmount ?? this.totalAmount,
      chartDataList: chartDataList ?? this.chartDataList,
    );
  }
}
