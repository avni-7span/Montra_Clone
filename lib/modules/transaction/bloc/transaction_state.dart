part of 'transaction_bloc.dart';

enum TransactionStateStatus { initial, success, failure, loading }

class TransactionState extends Equatable {
  const TransactionState({
    this.status = TransactionStateStatus.initial,
    this.errorMessage = '',
    this.dataByDayMap = const {},
    this.filterBy,
    this.sortBy,
    this.categoryFilter,
  });

  final TransactionStateStatus status;
  final String errorMessage;
  final Map<String, List<TransactionModel>> dataByDayMap;
  final String? filterBy;
  final String? sortBy;
  final String? categoryFilter;

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        dataByDayMap,
        filterBy,
        sortBy,
        categoryFilter,
      ];

  TransactionState copyWith({
    TransactionStateStatus? status,
    String? errorMessage,
    Map<String, List<TransactionModel>>? dataByDayMap,
    String? filterBy,
    String? sortBy,
    String? categoryFilter,
  }) {
    return TransactionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      dataByDayMap: dataByDayMap ?? this.dataByDayMap,
      filterBy: filterBy ?? this.filterBy,
      sortBy: sortBy ?? this.sortBy,
      categoryFilter: categoryFilter ?? this.categoryFilter,
    );
  }
}
