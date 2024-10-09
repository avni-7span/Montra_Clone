part of 'financial_analysis_bloc.dart';

abstract class FinancialAnalysisEvent extends Equatable {
  const FinancialAnalysisEvent();
}

class AnalysisTypeChangeEvent extends FinancialAnalysisEvent {
  const AnalysisTypeChangeEvent({required this.isAnalysisBudgetType});

  final bool isAnalysisBudgetType;

  @override
  List<Object?> get props => [isAnalysisBudgetType];
}

class AnalysisFilterChangeEvent extends FinancialAnalysisEvent {
  const AnalysisFilterChangeEvent({required this.analysisFilter});

  final AnalysisFilter analysisFilter;

  @override
  List<Object?> get props => [analysisFilter];
}

class FetchDataListEvent extends FinancialAnalysisEvent {
  const FetchDataListEvent();
  @override
  List<Object?> get props => [];
}

class SetFilterTypeEvent extends FinancialAnalysisEvent {
  const SetFilterTypeEvent({required this.filterName});

  final String? filterName;

  @override
  List<Object?> get props => [filterName];
}
