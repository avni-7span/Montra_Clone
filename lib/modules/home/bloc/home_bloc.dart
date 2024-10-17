import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/core/utils/fire_store_queries.dart';
import 'package:montra_clone/modules/expense_tracking/models/transaction_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchAllTransactionData>(_fetchAllTransactionData);
    on<FetchAmountDetails>(_fetchAmountDetails);
    on<SetFilterEvent>(_setFilter);
    on<FetchDataByMonth>(_fetchDataByMonth);
    on<FetchDataByYear>(_fetchDataByYear);
    on<FetchDataByWeek>(_fetchDataByWeek);
    on<FetchDataOfCurrentDay>(_fetchDataOfCurrentDay);
  }

  Future<void> _fetchAllTransactionData(
    FetchAllTransactionData event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStateStatus.transactionDataLoading));
      final collectionReference =
          await FireStoreQueries.instance.getCollectionReference();
      final querySnapshot = await collectionReference.get();
      final transactionList = querySnapshot.docs
          .map(
            (snapshot) => TransactionModel.fromFireStore(
              snapshot.data(),
            ),
          )
          .toList();
      transactionList.sort(
        (a, b) => a.createdAt.compareTo(b.createdAt),
      );
      final list = transactionList.reversed.toList();
      emit(state.copyWith(
          status: HomeStateStatus.success, transactionList: list));
    } catch (e) {
      emit(state.copyWith(
          status: HomeStateStatus.failure,
          errorMessage: 'Something went wrong'));
    }
  }

  Future<void> _fetchAmountDetails(
    FetchAmountDetails event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStateStatus.amountLoading));
      final collectionReference =
          await FireStoreQueries.instance.getCollectionReference();
      final querySnapshot = await collectionReference.get();
      final List<double> incomeList = [];
      final List<double> expenseList = [];
      for (var e in querySnapshot.docs) {
        final mapData = e.data();
        if (mapData['isExpense'] == true) {
          expenseList.add(
            double.parse(
              mapData['transactionAmount'],
            ),
          );
        } else {
          incomeList.add(
            double.parse(
              mapData['transactionAmount'],
            ),
          );
        }
      }
      final double totalExpense = expenseList.fold(
        0,
        (previousValue, element) => previousValue + element,
      );
      final double totalIncome = incomeList.fold(
        0,
        (previousValue, element) => previousValue + element,
      );
      emit(
        state.copyWith(
          status: HomeStateStatus.success,
          totalExpense: totalExpense,
          totalIncome: totalIncome,
          totalAccountBalance: totalIncome - totalExpense,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStateStatus.failure,
          errorMessage: 'Something went wrong!',
        ),
      );
    }
  }

  void _setFilter(
    SetFilterEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(filterName: event.filterName));
  }

  /// today's data
  Future<void> _fetchDataOfCurrentDay(
    FetchDataOfCurrentDay event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStateStatus.transactionDataLoading));
      final docSnapShot = await FireStoreQueries.instance.getTodayData();

      final listTwo = docSnapShot.$2.map(
        (e) {
          return TransactionModel.fromFireStore(e.data());
        },
      ).toList();
      final listOne = docSnapShot.$1.map(
        (e) {
          return TransactionModel.fromFireStore(e.data());
        },
      ).toList();
      final List<TransactionModel> list = [];
      for (var e in listOne) {
        if (listTwo.contains(e)) {
          list.add(e);
        }
      }
      list.sort(
        (a, b) => a.createdAt.compareTo(b.createdAt),
      );
      final dataList = list.reversed.toList();
      emit(state.copyWith(
          status: HomeStateStatus.success, transactionList: dataList));
    } catch (e) {
      emit(
        state.copyWith(
            status: HomeStateStatus.failure,
            errorMessage: 'Something went wrong'),
      );
    }
  }

  /// data of this week
  Future<void> _fetchDataByWeek(
    FetchDataByWeek event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStateStatus.transactionDataLoading));
      final querySnapshot = await FireStoreQueries.instance.getThisWeekData();
      final list = querySnapshot
          .map(
            (docSnapshot) => TransactionModel.fromFireStore(
              docSnapshot.data(),
            ),
          )
          .toList();
      list.sort(
        (a, b) => a.createdAt.compareTo(b.createdAt),
      );
      final dataList = list.reversed.toList();
      emit(state.copyWith(
          status: HomeStateStatus.success, transactionList: dataList));
    } catch (e) {
      emit(state.copyWith(
          status: HomeStateStatus.failure,
          errorMessage: 'Something went wrong'));
    }
  }

  /// data of this month
  Future<void> _fetchDataByMonth(
    FetchDataByMonth event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStateStatus.transactionDataLoading));
      final querySnapshot =
          await FireStoreQueries.instance.getThisMonthExpenseIncomeData();
      final list = querySnapshot
          .map(
            (docSnapshot) => TransactionModel.fromFireStore(
              docSnapshot.data(),
            ),
          )
          .toList();
      list.sort(
        (a, b) => a.createdAt.compareTo(b.createdAt),
      );
      final dataList = list.reversed.toList();
      emit(state.copyWith(
          status: HomeStateStatus.success, transactionList: dataList));
    } catch (e) {
      emit(state.copyWith(
          status: HomeStateStatus.failure,
          errorMessage: 'Something went wrong'));
    }
  }

  /// data of this year
  Future<void> _fetchDataByYear(
    FetchDataByYear event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStateStatus.transactionDataLoading));
      final querySnapshot = await FireStoreQueries.instance.getThisYearData();
      final list = querySnapshot
          .map(
            (docSnapshot) => TransactionModel.fromFireStore(
              docSnapshot.data(),
            ),
          )
          .toList();
      list.sort(
        (a, b) => a.createdAt.compareTo(b.createdAt),
      );
      final dataList = list.reversed.toList();
      emit(
        state.copyWith(
          status: HomeStateStatus.success,
          transactionList: dataList,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStateStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }
}
