part of 'transaction_bloc.dart';

enum TransactionStateStatus {
  initial,
  success,
  failure,
  loading,
  noFiltersApplied
}

class TransactionState extends Equatable {
  const TransactionState({
    this.status = TransactionStateStatus.initial,
    this.errorMessage = '',
    this.transactionMap = const {},
    this.filterBy,
    this.sortBy,
    this.categoryFilter,
    this.isDataInList = false,
    this.transactionList = const [],
  });

  final TransactionStateStatus status;
  final String errorMessage;
  final Map<String, List<TransactionModel>> transactionMap;
  final String? filterBy;
  final String? sortBy;
  final String? categoryFilter;
  final bool isDataInList;
  final List<TransactionModel> transactionList;

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        transactionMap,
        filterBy,
        sortBy,
        categoryFilter,
        isDataInList,
        transactionList,
      ];

  TransactionState copyWith({
    TransactionStateStatus? status,
    String? errorMessage,
    Map<String, List<TransactionModel>>? transactionMap,
    String? filterBy,
    String? sortBy,
    String? categoryFilter,
    bool? isDataInList,
    List<TransactionModel>? transactionList,
  }) {
    return TransactionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      transactionMap: transactionMap ?? this.transactionMap,
      filterBy: filterBy ?? this.filterBy,
      sortBy: sortBy ?? this.sortBy,
      categoryFilter: categoryFilter ?? this.categoryFilter,
      isDataInList: isDataInList ?? this.isDataInList,
      transactionList: transactionList ?? this.transactionList,
    );
  }
}
