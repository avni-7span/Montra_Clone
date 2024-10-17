import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/core/validators/empty_field_validator.dart';
import 'package:montra_clone/modules/expense_tracking/models/transaction_model.dart';
import 'package:uuid/uuid.dart';

part 'expense_tracker_event.dart';

part 'expense_tracker_state.dart';

class ExpenseTrackerBloc
    extends Bloc<ExpenseTrackerEvent, ExpenseTrackerState> {
  ExpenseTrackerBloc() : super(const ExpenseTrackerState()) {
    on<AddTransactionToFireStoreEvent>(_addTransactionDataToFireStore);
    on<AmountFieldChangeEvent>(_checkAmountField);
    on<DescriptionFieldChangeEvent>(_checkDescriptionField);
    on<SetCategoryEvent>(_setCategory);
    on<UpdateTransactionDataEvent>(_updateTransactionData);
    on<DeleteTransactionDataEvent>(_deleteTransactionData);
    on<EmitSelectedTransactionDetailsEvent>(
        _emitSelectedTransactionDetailsEvent);
  }

  final db = FirebaseFirestore.instance;
  final currentUser = AuthenticationRepository.instance.currentUser;
  final uuid = const Uuid();

  Future<void> _addTransactionDataToFireStore(
    AddTransactionToFireStoreEvent event,
    Emitter<ExpenseTrackerState> emit,
  ) async {
    final description = EmptyFieldValidator.dirty(state.description.value);
    final amount = EmptyFieldValidator.dirty(state.transactionAmount.value);
    emit(
      state.copyWith(
        description: description,
        transactionAmount: amount,
        isValid: Formz.validate(
          [description, amount],
        ),
      ),
    );
    if (state.category != null || state.category == '') {
      if (state.isValid) {
        emit(state.copyWith(status: ExpenseTrackerStateStatus.loading));
        final transactionDocRef = db
            .collection('users')
            .doc(currentUser?.uid)
            .collection('transaction');
        await transactionDocRef.add(
          TransactionModel.toFireStore(
            TransactionModel(
              transactionId: uuid.v4(),
              transactionAmount: state.transactionAmount.value,
              description: state.description.value,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              category: state.category!,
              isExpense: event.isExpense,
            ),
          ),
        );
        emit(state.copyWith(status: ExpenseTrackerStateStatus.success));
      }
    } else {
      emit(
        state.copyWith(
          status: ExpenseTrackerStateStatus.failure,
          errorMessage: 'Choose the category.',
        ),
      );
    }
  }

  void _checkDescriptionField(DescriptionFieldChangeEvent event,
      Emitter<ExpenseTrackerState> emit) async {
    final description = EmptyFieldValidator.dirty(event.description);
    emit(
      state.copyWith(
        description: description,
        isValid: Formz.validate([description]),
      ),
    );
  }

  Future<void> _checkAmountField(
      AmountFieldChangeEvent event, Emitter<ExpenseTrackerState> emit) async {
    final amount = EmptyFieldValidator.dirty(event.amount);
    emit(
      state.copyWith(
        transactionAmount: amount,
        isValid: Formz.validate(
          [amount],
        ),
      ),
    );
  }

  void _setCategory(SetCategoryEvent event, Emitter<ExpenseTrackerState> emit) {
    emit(state.copyWith(category: event.category));
  }

  Future<void> _updateTransactionData(
    UpdateTransactionDataEvent event,
    Emitter<ExpenseTrackerState> emit,
  ) async {
    try {
      final description = EmptyFieldValidator.dirty(state.description.value);
      final amount = EmptyFieldValidator.dirty(state.transactionAmount.value);
      emit(
        state.copyWith(
          description: description,
          transactionAmount: amount,
          isValid: Formz.validate(
            [description, amount],
          ),
        ),
      );
      if (state.category != null || state.category == '') {
        if (state.isValid) {
          emit(state.copyWith(status: ExpenseTrackerStateStatus.updateLoading));
          final snapshot = await db
              .collection('users')
              .doc(currentUser?.uid)
              .collection('transaction')
              .where('transactionId', isEqualTo: event.transactionId)
              .get();
          final docId = snapshot.docs[0].id;
          await db
              .collection('users')
              .doc(currentUser?.uid)
              .collection('transaction')
              .doc(docId)
              .update({
            'category': state.category,
            'description': state.description.value,
            'transactionAmount': state.transactionAmount.value,
          });
          emit(state.copyWith(status: ExpenseTrackerStateStatus.updated));
        }
      } else {
        emit(
          state.copyWith(
            status: ExpenseTrackerStateStatus.failure,
            errorMessage: 'Choose the category.',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ExpenseTrackerStateStatus.failure,
          errorMessage: 'Could not edit transaction details',
        ),
      );
    }
  }

  Future<void> _deleteTransactionData(
    DeleteTransactionDataEvent event,
    Emitter<ExpenseTrackerState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ExpenseTrackerStateStatus.deleteDataLoading));
      final snapshot = await db
          .collection('users')
          .doc(currentUser?.uid)
          .collection('transaction')
          .where('transactionId', isEqualTo: event.transactionId)
          .get();
      final docId = snapshot.docs[0].id;
      await db
          .collection('users')
          .doc(currentUser?.uid)
          .collection('transaction')
          .doc(docId)
          .delete();
      emit(state.copyWith(status: ExpenseTrackerStateStatus.deleted));
    } catch (e) {
      emit(
        state.copyWith(
            status: ExpenseTrackerStateStatus.failure,
            errorMessage: 'Could not delete data.'),
      );
    }
  }

  void _emitSelectedTransactionDetailsEvent(
      EmitSelectedTransactionDetailsEvent event,
      Emitter<ExpenseTrackerState> emit) {
    emit(
      state.copyWith(
        transactionAmount:
            EmptyFieldValidator.dirty(event.transactionModel.transactionAmount),
        description:
            EmptyFieldValidator.dirty(event.transactionModel.description),
        category: event.transactionModel.category,
      ),
    );
  }
}
