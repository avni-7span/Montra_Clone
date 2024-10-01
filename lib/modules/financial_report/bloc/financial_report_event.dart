part of 'financial_report_bloc.dart';

abstract class FinancialReportEvent extends Equatable {
  const FinancialReportEvent();
}

class PageChangeEvent extends FinancialReportEvent {
  const PageChangeEvent({required this.index});

  final int index;

  @override
  List<Object?> get props => [index];
}

class FetchThisMonthFinancialReportEvent extends FinancialReportEvent {
  const FetchThisMonthFinancialReportEvent();

  @override
  List<Object?> get props => [];
}
