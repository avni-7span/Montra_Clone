import 'dart:async';

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
      print('Map aavo chhe : $groupedData');
      emit(state.copyWith(
          status: TransactionStateStatus.success, dataByDayMap: groupedData));
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
    print('categoryFilter before : ${state.categoryFilter}');
    emit(state.copyWith(filterBy: event.filterBy, categoryFilter: null));
    print('categoryFilter after : ${state.categoryFilter}');
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
}
