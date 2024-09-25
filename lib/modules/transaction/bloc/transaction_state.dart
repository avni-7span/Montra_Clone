part of 'transaction_bloc.dart';

enum TransactionStateStatus { initial, success, failure, loading }

class TransactionState extends Equatable {
  const TransactionState({
    this.currentIndex = 0,
    this.status = TransactionStateStatus.initial,
    this.errorMessage = '',
    this.dataByDayMap = const {},
  });

  final TransactionStateStatus status;
  final int currentIndex;
  final String errorMessage;
  final Map<String, List<TransactionModel>> dataByDayMap;

  @override
  List<Object?> get props => [
        currentIndex,
        status,
        errorMessage,
        dataByDayMap,
      ];

  TransactionState copyWith({
    TransactionStateStatus? status,
    int? currentIndex,
    String? errorMessage,
    Map<String, List<TransactionModel>>? dataByDayDayList,
  }) {
    return TransactionState(
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
      errorMessage: errorMessage ?? this.errorMessage,
      dataByDayMap: dataByDayDayList ?? this.dataByDayMap,
    );
  }
}
