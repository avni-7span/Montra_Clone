part of 'financial_analysis_bloc.dart';

abstract class FinancialAnalysisEvent extends Equatable {
  const FinancialAnalysisEvent();
}

class PageChangeEvent extends FinancialAnalysisEvent {
  const PageChangeEvent({required this.index});

  final int index;

  @override
  List<Object?> get props => [index];
}
