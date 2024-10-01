import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/core/utils/fire_store_queries.dart';
import 'package:montra_clone/modules/expense_tracking/models/transaction_model.dart';
import 'package:montra_clone/modules/financial_analysis/model/chart_data_model.dart';

part 'financial_analysis_event.dart';

part 'financial_analysis_state.dart';

class FinancialAnalysisBloc
    extends Bloc<FinancialAnalysisEvent, FinancialAnalysisState> {
  FinancialAnalysisBloc() : super(const FinancialAnalysisState()) {
    on<AnalysisTypeChangeEvent>(_setAnalysisType);
    on<AnalysisFilterChangeEvent>(_setAnalysisFilter);
    on<FetchDataListEvent>(_fetchDataList);
  }

  void _setAnalysisType(
    AnalysisTypeChangeEvent event,
    Emitter<FinancialAnalysisState> emit,
  ) {
    emit(state.copyWith(isAnalysisBudgetType: event.isAnalysisBudgetType));
  }

  void _setAnalysisFilter(
    AnalysisFilterChangeEvent event,
    Emitter<FinancialAnalysisState> emit,
  ) {
    emit(state.copyWith(filterType: event.analysisFilter));
  }

  Future<void> _fetchDataList(
    FetchDataListEvent event,
    Emitter<FinancialAnalysisState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FinancialAnalysisStateStatus.loading));
      final querySnapshot = await FireStoreQueries.instance.getThisMonthData();
      final List<TransactionModel> dataList = [];
      final List<ChartDataModel> amountList = [];
      final isExpense =
          state.filterType == AnalysisFilter.expense ? true : false;
      for (var snapshot in querySnapshot) {
        if (snapshot.data()['isExpense'] == isExpense) {
          dataList.add(TransactionModel.fromFireStore(snapshot.data()));
          amountList.add(
            ChartDataModel(
              dateTime: DateTime.fromMillisecondsSinceEpoch(
                  snapshot.data()['createdAt']),
              amount: double.parse(snapshot.data()['transactionAmount']),
            ),
          );
        }
      }

      final double totalAmount = dataList.fold(
        0,
        (previousValue, element) =>
            previousValue + double.parse(element.transactionAmount),
      );
      emit(state.copyWith(
        status: FinancialAnalysisStateStatus.success,
        transactionList: dataList,
        totalAmount: totalAmount,
        chartDataList: amountList,
      ));
    } catch (e) {
      emit(state.copyWith(status: FinancialAnalysisStateStatus.failure));
    }
  }
}
