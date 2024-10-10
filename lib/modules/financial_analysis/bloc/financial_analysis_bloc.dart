import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/core/utils/fire_store_queries.dart';
import 'package:montra_clone/modules/expense_tracking/models/transaction_model.dart';
import 'package:montra_clone/modules/financial_analysis/model/chart_data_model.dart';
import 'package:montra_clone/modules/financial_analysis/model/doughnut_chart_model.dart';

part 'financial_analysis_event.dart';

part 'financial_analysis_state.dart';

class FinancialAnalysisBloc
    extends Bloc<FinancialAnalysisEvent, FinancialAnalysisState> {
  FinancialAnalysisBloc() : super(const FinancialAnalysisState()) {
    on<AnalysisTypeChangeEvent>(_setAnalysisType);
    on<AnalysisFilterChangeEvent>(_setAnalysisFilter);
    on<SetFilterTypeEvent>(_setDataFilterType);
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
    emit(state.copyWith(analysisFilterType: event.analysisFilter));
  }

  void _setDataFilterType(
    SetFilterTypeEvent event,
    Emitter<FinancialAnalysisState> emit,
  ) {
    DataFilterType dataFilterType;
    if (event.filterName == 'Month') {
      dataFilterType = DataFilterType.month;
    } else if (event.filterName == 'Year') {
      dataFilterType = DataFilterType.year;
    } else {
      dataFilterType = DataFilterType.week;
    }
    emit(state.copyWith(dataFilterType: dataFilterType));
  }

  Future<void> _fetchDataList(
    FetchDataListEvent event,
    Emitter<FinancialAnalysisState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FinancialAnalysisStateStatus.loading));
      List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapshot;
      if (state.dataFilterType == DataFilterType.week) {
        querySnapshot = await FireStoreQueries.instance.getThisWeekData();
      } else if (state.dataFilterType == DataFilterType.year) {
        querySnapshot = await FireStoreQueries.instance.getThisYearData();
      } else {
        querySnapshot =
            await FireStoreQueries.instance.getThisMonthExpenseIncomeData();
      }
      final List<TransactionModel> dataList = [];
      final List<ChartDataModel> amountList = [];
      final isExpense =
          state.analysisFilterType == AnalysisFilter.expense ? true : false;
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

      final List<String> categoryList = [
        'Food',
        'Subscription',
        'Shopping',
        'Transportation',
        'Salary',
        'Rental Income',
        'Interest',
      ];
      final Map<String, double> categoryMap = {};
      for (var category in categoryList) {
        final double categoryAmount =
            dataList.where((model) => model.category == category).toList().fold(
                  0,
                  (previousValue, element) =>
                      previousValue + double.parse(element.transactionAmount),
                );
        categoryMap[category] = (categoryAmount / totalAmount);
      }
      final expenseChartList = [
        DoughnutChartData(
          category: 'Subscription',
          color: AppColors.instance.primary,
          value: categoryMap['Subscription']!,
        ),
        DoughnutChartData(
          category: 'Shopping',
          color: AppColors.instance.yellow100,
          value: categoryMap['Shopping']!,
        ),
        DoughnutChartData(
          category: 'Transportation',
          color: AppColors.instance.blue100,
          value: categoryMap['Transportation']!,
        ),
        DoughnutChartData(
          category: 'Food',
          color: AppColors.instance.red100,
          value: categoryMap['Food']!,
        ),
      ];

      final incomeChartList = [
        DoughnutChartData(
          category: 'Salary',
          color: AppColors.instance.green100,
          value: categoryMap['Salary']!,
        ),
        DoughnutChartData(
          category: 'Rental Income',
          color: AppColors.instance.yellow100,
          value: categoryMap['Rental Income']!,
        ),
        DoughnutChartData(
          category: 'Interest',
          color: AppColors.instance.blue100,
          value: categoryMap['Interest']!,
        )
      ];

      emit(state.copyWith(
        status: FinancialAnalysisStateStatus.success,
        transactionList: dataList,
        totalAmount: totalAmount,
        chartDataList: amountList,
        categoryRateMap: categoryMap,
        incomeChartList: incomeChartList,
        expenseChartList: expenseChartList,
      ));
    } catch (e) {
      emit(state.copyWith(status: FinancialAnalysisStateStatus.failure));
    }
  }
}
