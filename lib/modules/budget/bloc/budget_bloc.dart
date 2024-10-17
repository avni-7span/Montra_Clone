import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:montra_clone/core/utils/fire_store_queries.dart';
import 'package:montra_clone/core/validators/empty_field_validator.dart';
import 'package:montra_clone/modules/budget/models/budget_data_model.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  BudgetBloc() : super(const BudgetState()) {
    on<AmountTextFieldChangeEvent>(_amountFieldChange);
    on<SetCategoryEvent>(_setCategory);
    on<ReceiveAlertSwitchChangeEvent>(_setSwitchValue);
    on<SliderChangeEvent>(_setSliderValue);
    on<LoadCategoryList>(_loadCategoryList);
    on<ContinueButtonTapEvent>(_addDataToFireStore);
    on<LoadBudgetDataFromFireStoreEvent>(_loadData);
    on<DeleteBudgetEvent>(_deleteBudget);
    on<UpdateBudgetEvent>(_updateBudget);
  }

  void _setCategory(
    SetCategoryEvent event,
    Emitter<BudgetState> emit,
  ) {
    emit(state.copyWith(category: event.category));
  }

  void _setSwitchValue(
    ReceiveAlertSwitchChangeEvent event,
    Emitter<BudgetState> emit,
  ) {
    emit(state.copyWith(shouldReceiveAlert: event.shouldReceiveAlert));
  }

  void _setSliderValue(
    SliderChangeEvent event,
    Emitter<BudgetState> emit,
  ) {
    emit(state.copyWith(sliderValue: event.sliderValue));
  }

  void _amountFieldChange(
    AmountTextFieldChangeEvent event,
    Emitter<BudgetState> emit,
  ) {
    final amount = EmptyFieldValidator.dirty(event.amount);
    emit(
      state.copyWith(
        amount: amount,
        isValid: Formz.validate(
          [amount],
        ),
      ),
    );
  }

  Future<void> _addDataToFireStore(
    ContinueButtonTapEvent event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      final amount = EmptyFieldValidator.dirty(state.amount.value);
      emit(
        state.copyWith(
          amount: amount,
          isValid: Formz.validate(
            [amount],
          ),
        ),
      );
      if (state.isValid) {
        if (state.category != null) {
          final collectionReference =
              await FireStoreQueries.instance.getBudgetCollectionReference();
          if (state.shouldReceiveAlert) {
            emit(state.copyWith(status: BudgetStateStatus.loading));
            await collectionReference.add({
              'createdAt': DateTime.now().millisecondsSinceEpoch,
              'category': state.category,
              'budgetAmount': double.parse(state.amount.value),
              'alertLimit': state.sliderValue,
              'shouldReceiveAlert': state.shouldReceiveAlert,
            });
            emit(state.copyWith(status: BudgetStateStatus.success));
          } else {
            emit(state.copyWith(status: BudgetStateStatus.loading));
            await collectionReference.add({
              'createdAt': DateTime.now().millisecondsSinceEpoch,
              'category': state.category,
              'budgetAmount': double.parse(state.amount.value),
              'shouldReceiveAlert': state.shouldReceiveAlert,
            });
            emit(state.copyWith(status: BudgetStateStatus.success));
          }
        } else {
          emit(state.copyWith(
            status: BudgetStateStatus.failure,
            errorMessage: 'Please select Category',
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(
          status: BudgetStateStatus.failure,
          errorMessage: 'Something went wrong,Please try again later'));
    }
  }

  Future<List<BudgetDataModel>> getBudgetData() async {
    final queryDocSnapshot =
        await FireStoreQueries.instance.getThisMonthBudgetData();
    final List<BudgetDataModel> budgetDataModelList = [];
    for (var element in queryDocSnapshot) {
      budgetDataModelList.add(
        BudgetDataModel(
          createdAt: element.data()['createdAt'],
          category: element.data()['category'],
          budgetAmount: (element.data()['budgetAmount']).toDouble(),
          budgetId: element.id,
          alertLimit: (element.data()['shouldReceiveAlert'] == false)
              ? null
              : (element.data()['alertLimit']).toDouble(),
          shouldReceiveAlert: element.data()['shouldReceiveAlert'],
        ),
      );
    }
    return budgetDataModelList;
  }

  Map<String, double> getCategoryMap(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> queryDocSnapshot) {
    final categoryList = ['Food', 'Subscription', 'Shopping', 'Transportation'];
    final Map<String, double> categoryMap = {};
    for (var category in categoryList) {
      final spentAmountList = [];
      for (var a in queryDocSnapshot) {
        if (a.data()['category'] == category) {
          spentAmountList.add(double.parse(a.data()['transactionAmount']));
        }
      }
      final amount = spentAmountList.fold(
        0.0,
        (previousValue, element) => previousValue + element,
      );
      categoryMap[category] = amount;
    }
    return categoryMap;
  }

  Future<void> _loadData(
    LoadBudgetDataFromFireStoreEvent event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BudgetStateStatus.loading));
      final budgetDataList = await getBudgetData();
      final queryDocSnapshot =
          await FireStoreQueries.instance.getThisMonthExpenseIncomeData();
      final categoryMap = getCategoryMap(queryDocSnapshot);
      emit(state.copyWith(
        status: BudgetStateStatus.success,
        spentAmountMap: categoryMap,
        budgetDataModelList: budgetDataList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BudgetStateStatus.failure,
        errorMessage: 'Something went wrong',
      ));
    }
  }

  Future<void> _loadCategoryList(
    LoadCategoryList event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      final categoryList = [
        'Food',
        'Subscription',
        'Shopping',
        'Transportation'
      ];
      final ref =
          await FireStoreQueries.instance.getBudgetCollectionReference();
      final snapshot = await ref.get();
      final dataList = snapshot.docs;
      if (dataList.isNotEmpty) {
        for (var e in dataList) {
          if (categoryList.contains(e.data()['category'])) {
            categoryList.remove(e.data()['category']);
          }
        }
      }
      emit(state.copyWith(categoryList: categoryList));
    } catch (e) {
      emit(state.copyWith(
          status: BudgetStateStatus.failure,
          errorMessage: 'Could not load list data'));
    }
  }

  Future<void> _deleteBudget(
    DeleteBudgetEvent event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      final ref =
          await FireStoreQueries.instance.getBudgetCollectionReference();
      await ref.doc(event.budgetID).delete();
      emit(state.copyWith(status: BudgetStateStatus.deletedSuccessfully));
    } catch (e) {
      emit(state.copyWith(
          status: BudgetStateStatus.failure,
          errorMessage: 'Could not delete budget! Please try again.'));
    }
  }

  Future<void> _updateBudget(
    UpdateBudgetEvent event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      final amount = EmptyFieldValidator.dirty(state.amount.value == ''
          ? event.budgetAmount.toString()
          : state.amount.value);
      emit(
        state.copyWith(
          status: BudgetStateStatus.loading,
          amount: amount,
          isValid: Formz.validate(
            [amount],
          ),
        ),
      );
      if (state.isValid) {
        final ref =
            await FireStoreQueries.instance.getBudgetCollectionReference();
        await ref.doc(event.budgetID).update({
          'budgetAmount': double.parse(state.amount.value),
          'shouldReceiveAlert': state.shouldReceiveAlert,
          'alertLimit':
              !state.shouldReceiveAlert ? null : state.sliderValue ?? 80,
        });
        emit(state.copyWith(status: BudgetStateStatus.updatedSuccessfully));
      } else {
        emit(state.copyWith(
          status: BudgetStateStatus.failure,
          errorMessage: 'Something went wrong.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: BudgetStateStatus.failure,
        errorMessage: 'Could not update budget! Please try again.',
      ));
    }
  }
}
