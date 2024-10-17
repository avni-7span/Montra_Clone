import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/core/utils/fire_store_queries.dart';
import 'package:montra_clone/modules/expense_tracking/models/transaction_model.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(const TransactionState()) {
    on<FetchDataByDayEvent>(_fetchDataByDay);
    on<SetFilterByEvent>(_setFilterBy);
    on<SetSortByEvent>(_setSortBy);
    on<SetCategoryFilterEvent>(_setCategoryFilter);
    on<ResetFilterEvent>(_resetFilters);
    on<FetchDataByFilterEvent>(_fetchDataByFilter);
  }

  Map<String, List<TransactionModel>> getDataGroupedByDates(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    docs.sort(
      (a, b) => b.data()['createdAt'].compareTo(
            a.data()['createdAt'],
          ),
    );
    Map<String, List<TransactionModel>> groupedData = {};
    for (var doc in docs) {
      final data = doc.data();
      String formattedDate =
          FireStoreQueries.instance.getFormatedDate(data['createdAt']);
      if (groupedData.containsKey(formattedDate)) {
        groupedData[formattedDate]!.add(TransactionModel.fromFireStore(data));
      } else {
        groupedData[formattedDate] = [TransactionModel.fromFireStore(data)];
      }
    }
    return groupedData;
  }

  Map<String, List<TransactionModel>> getReversedMap(
      {required Map<String, List<TransactionModel>> mapToReverse}) {
    final mapKeyList = mapToReverse.keys.toList();
    final keyList = mapKeyList.reversed.toList();
    Map<String, List<TransactionModel>> reversedMap = {};
    for (String key in keyList) {
      reversedMap[key] = mapToReverse[key]!;
    }
    return reversedMap;
  }

  List<TransactionModel> getDataInDescendingOrder(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docList) {
    final list = docList
        .map(
          (docSnapshot) => TransactionModel.fromFireStore(
            docSnapshot.data(),
          ),
        )
        .toList();
    list.sort(
      (a, b) => double.parse(b.transactionAmount)
          .compareTo(double.parse(a.transactionAmount)),
    );
    return list;
  }

  Future<void> _fetchDataByDay(
    TransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      emit(state.copyWith(status: TransactionStateStatus.loading));
      final reference =
          await FireStoreQueries.instance.getCollectionReference();
      final querySnapshot = await reference.get();

      final docs = querySnapshot.docs;
      final groupedData = getDataGroupedByDates(docs);
      emit(state.copyWith(
          status: TransactionStateStatus.success,
          transactionMap: groupedData,
          isDataInList: false));
    } catch (e) {
      emit(state.copyWith(
          status: TransactionStateStatus.failure,
          errorMessage: 'Could not load data'));
    }
  }

  void _setFilterBy(
    SetFilterByEvent event,
    Emitter<TransactionState> emit,
  ) {
    emit(TransactionState(
      filterBy: event.filterBy,
      categoryFilter: null,
      sortBy: state.sortBy,
      status: state.status,
      transactionMap: state.transactionMap,
      errorMessage: state.errorMessage,
      isDataInList: state.isDataInList,
      transactionList: state.transactionList,
    ));
  }

  void _setSortBy(
    SetSortByEvent event,
    Emitter<TransactionState> emit,
  ) {
    emit(state.copyWith(sortBy: event.sortBy));
  }

  void _setCategoryFilter(
    SetCategoryFilterEvent event,
    Emitter<TransactionState> emit,
  ) {
    emit(state.copyWith(categoryFilter: event.categoryFilter));
  }

  void _resetFilters(
    ResetFilterEvent event,
    Emitter<TransactionState> emit,
  ) {
    emit(TransactionState(
      categoryFilter: null,
      sortBy: null,
      filterBy: null,
      status: state.status,
      errorMessage: state.errorMessage,
      transactionMap: state.transactionMap,
      isDataInList: state.isDataInList,
      transactionList: state.transactionList,
    ));
  }

  FutureOr<void> _fetchDataByFilter(
    FetchDataByFilterEvent event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      if (state.filterBy == null &&
          state.sortBy == null &&
          state.categoryFilter == null) {
        add(const FetchDataByDayEvent());
      } else if (state.filterBy == null) {
        emit(
          state.copyWith(
            status: TransactionStateStatus.failure,
            errorMessage:
                'Please select from either Expense or Income to apply filter',
          ),
        );
      } else if (state.filterBy != null) {
        final querySnapshotList = await FireStoreQueries.instance
            .getDataByIsExpenseFlag(isExpense: state.filterBy == 'Expense');
        List<QueryDocumentSnapshot<Map<String, dynamic>>> docList = [];
        if (state.categoryFilter != null) {
          for (var e in querySnapshotList) {
            if (e.data()['category'] == state.categoryFilter) {
              docList.add(e);
            }
          }
        } else {
          docList = querySnapshotList;
        }
        if (state.sortBy == null) {
          emit(state.copyWith(status: TransactionStateStatus.loading));
          final groupedData = getDataGroupedByDates(docList);
          emit(state.copyWith(
            status: TransactionStateStatus.success,
            transactionMap: groupedData,
            isDataInList: false,
          ));
        } else {
          if (state.sortBy == 'Newest') {
            emit(state.copyWith(status: TransactionStateStatus.loading));
            final groupedData = getDataGroupedByDates(docList);
            emit(
              state.copyWith(
                status: TransactionStateStatus.success,
                transactionMap: groupedData,
                isDataInList: false,
              ),
            );
          } else if (state.sortBy == 'Oldest') {
            emit(state.copyWith(status: TransactionStateStatus.loading));
            final map = getDataGroupedByDates(docList);
            final reversedMap = getReversedMap(mapToReverse: map);
            emit(
              state.copyWith(
                status: TransactionStateStatus.success,
                transactionMap: reversedMap,
                isDataInList: false,
              ),
            );
          } else if (state.sortBy == 'Highest') {
            emit(
              state.copyWith(status: TransactionStateStatus.loading),
            );
            final transactionList = getDataInDescendingOrder(docList);
            emit(
              state.copyWith(
                status: TransactionStateStatus.success,
                transactionList: transactionList,
                isDataInList: true,
              ),
            );
          } else {
            emit(state.copyWith(status: TransactionStateStatus.loading));
            final transactionList = getDataInDescendingOrder(docList);
            final list = transactionList.reversed.toList();
            emit(
              state.copyWith(
                status: TransactionStateStatus.success,
                transactionList: list,
                isDataInList: true,
              ),
            );
          }
        }
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStateStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }
}
