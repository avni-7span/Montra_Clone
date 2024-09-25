part of 'financial_analysis_bloc.dart';

enum FinancialAnalysisStateStatus { initial, success, failure, loading }

class FinancialAnalysisState extends Equatable {
  const FinancialAnalysisState({
    this.currentIndex = 0,
    this.status = FinancialAnalysisStateStatus.initial,
  });

  final FinancialAnalysisStateStatus status;
  final int currentIndex;

  @override
  List<Object?> get props => [currentIndex];

  FinancialAnalysisState copyWith({
    FinancialAnalysisStateStatus? status,
    int? currentIndex,
  }) {
    return FinancialAnalysisState(
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
