part of 'home_bloc.dart';

enum HomeStateStatus { loading, initial, failure, success }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStateStatus.initial,
    this.transactionList = const [],
    this.errorMessage = '',
    this.expenseList = const [],
    this.incomeList = const [],
    this.totalAccountBalance = '',
  });

  final HomeStateStatus status;
  final List<TransactionModel> transactionList;
  final List<double> incomeList;
  final List<double> expenseList;
  final String errorMessage;
  final String totalAccountBalance;

  @override
  List<Object?> get props => [
        status,
        transactionList,
        errorMessage,
        expenseList,
        incomeList,
        totalAccountBalance,
      ];

  HomeState copyWith({
    HomeStateStatus? status,
    List<TransactionModel>? transactionList,
    List<double>? incomeList,
    List<double>? expenseList,
    String? errorMessage,
    String? totalAccountBalance,
  }) {
    return HomeState(
      status: status ?? this.status,
      transactionList: transactionList ?? this.transactionList,
      incomeList: incomeList ?? this.incomeList,
      expenseList: expenseList ?? this.expenseList,
      errorMessage: errorMessage ?? this.errorMessage,
      totalAccountBalance: totalAccountBalance ?? this.totalAccountBalance,
    );
  }
}
