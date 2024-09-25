import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'financial_analysis_event.dart';
part 'financial_analysis_state.dart';

class FinancialAnalysisBloc
    extends Bloc<FinancialAnalysisEvent, FinancialAnalysisState> {
  FinancialAnalysisBloc() : super(const FinancialAnalysisState()) {
    on<PageChangeEvent>(_setIndex);
  }

  void _setIndex(
    PageChangeEvent event,
    Emitter<FinancialAnalysisState> emit,
  ) {
    emit(state.copyWith(currentIndex: event.index));
  }
}
