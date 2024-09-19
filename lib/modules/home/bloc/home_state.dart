part of 'home_bloc.dart';

enum HomeStateStatus {
  amountLoading,
  transactionDataLoading,
  initial,
  failure,
  success
}

class HomeState extends Equatable {
  const HomeState(
      {this.status = HomeStateStatus.initial,
      this.transactionList = const [],
      this.errorMessage = '',
      this.totalExpense = 0.0,
      this.totalIncome = 0.0,
      this.totalAccountBalance = 0.0,
      this.filterName = 'Today'});

  final HomeStateStatus status;
  final List<TransactionModel> transactionList;
  final double totalIncome;
  final double totalExpense;
  final String errorMessage;
  final double totalAccountBalance;
  final String filterName;

  @override
  List<Object?> get props => [
        status,
        transactionList,
        errorMessage,
        totalExpense,
        totalIncome,
        totalAccountBalance,
        filterName,
      ];

  HomeState copyWith({
    HomeStateStatus? status,
    List<TransactionModel>? transactionList,
    double? totalIncome,
    double? totalExpense,
    String? errorMessage,
    double? totalAccountBalance,
    String? filterName,
  }) {
    return HomeState(
      status: status ?? this.status,
      transactionList: transactionList ?? this.transactionList,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      errorMessage: errorMessage ?? this.errorMessage,
      totalAccountBalance: totalAccountBalance ?? this.totalAccountBalance,
      filterName: filterName ?? this.filterName,
    );
  }
}
