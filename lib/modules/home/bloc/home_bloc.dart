import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/modules/expense_tracking/models/transaction_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchTransactionList>(_fetchTransactionList);
    on<FetchAmountDetails>(_fetchAmountDetails);
  }

  final fireStoreInstance = FirebaseFirestore.instance;
  final currentUserId = AuthenticationRepository.instance.currentUser?.uid;

  Future<QuerySnapshot<Map<String, dynamic>>>
      getQuerySnapshotOfTransactionData() async {
    final transactionCollectionRef = fireStoreInstance
        .collection('users')
        .doc(currentUserId)
        .collection('transaction');
    final querySnapshot = await transactionCollectionRef.get();
    return querySnapshot;
  }

  Future<void> _fetchTransactionList(
    FetchTransactionList event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStateStatus.transactionDataLoading));
      final querySnapshot = await getQuerySnapshotOfTransactionData();
      final transactionList = querySnapshot.docs
          .map(
            (snapshot) => TransactionModel.fromFireStore(
              snapshot.data(),
            ),
          )
          .toList();
      emit(state.copyWith(
          status: HomeStateStatus.success, transactionList: transactionList));
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
      final querySnapshot = await getQuerySnapshotOfTransactionData();
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
}
