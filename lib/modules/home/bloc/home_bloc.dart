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
  }

  final fireStoreInstance = FirebaseFirestore.instance;
  final currentUserId = AuthenticationRepository.instance.currentUser?.uid;

  Future<void> _fetchTransactionList(
    FetchTransactionList event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStateStatus.loading));
      final transactionCollectionRef = fireStoreInstance
          .collection('users')
          .doc(currentUserId)
          .collection('transaction');
      final querySnapshot = await transactionCollectionRef.get();
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
}
