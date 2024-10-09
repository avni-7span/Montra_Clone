part of 'financial_analysis_bloc.dart';

enum AnalysisFilter { income, expense }

enum FinancialAnalysisStateStatus { initial, failure, success, loading }

enum DataFilterType { month, year, week }

class FinancialAnalysisState extends Equatable {
  const FinancialAnalysisState({
    this.status = FinancialAnalysisStateStatus.initial,
    this.isAnalysisBudgetType = true,
    this.analysisFilterType = AnalysisFilter.expense,
    this.transactionList = const [],
    this.totalAmount = 0,
    this.chartDataList = const [],
    this.dataFilterType = DataFilterType.month,
    this.categoryRateMap = const {},
    this.incomeChartList = const [],
    this.expenseChartList = const [],
  });

  final bool isAnalysisBudgetType;
  final FinancialAnalysisStateStatus status;
  final AnalysisFilter analysisFilterType;
  final List<TransactionModel> transactionList;
  final double totalAmount;
  final List<ChartDataModel> chartDataList;
  final DataFilterType dataFilterType;
  final Map<String, double> categoryRateMap;
  final List<DoughnutChartData> incomeChartList;
  final List<DoughnutChartData> expenseChartList;

  @override
  List<Object?> get props => [
        isAnalysisBudgetType,
        status,
        analysisFilterType,
        transactionList,
        totalAmount,
        chartDataList,
        dataFilterType,
        categoryRateMap,
        incomeChartList,
        expenseChartList,
      ];

  FinancialAnalysisState copyWith({
    bool? isAnalysisBudgetType,
    FinancialAnalysisStateStatus? status,
    AnalysisFilter? analysisFilterType,
    List<TransactionModel>? transactionList,
    double? totalAmount,
    List<ChartDataModel>? chartDataList,
    DataFilterType? dataFilterType,
    Map<String, double>? categoryRateMap,
    List<DoughnutChartData>? incomeChartList,
    List<DoughnutChartData>? expenseChartList,
  }) {
    return FinancialAnalysisState(
      isAnalysisBudgetType: isAnalysisBudgetType ?? this.isAnalysisBudgetType,
      status: status ?? this.status,
      analysisFilterType: analysisFilterType ?? this.analysisFilterType,
      transactionList: transactionList ?? this.transactionList,
      totalAmount: totalAmount ?? this.totalAmount,
      chartDataList: chartDataList ?? this.chartDataList,
      dataFilterType: dataFilterType ?? this.dataFilterType,
      categoryRateMap: categoryRateMap ?? this.categoryRateMap,
      incomeChartList: incomeChartList ?? this.incomeChartList,
      expenseChartList: expenseChartList ?? this.expenseChartList,
    );
  }
}
