part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();
}

class PageChangeEvent extends TransactionEvent {
  const PageChangeEvent({required this.index});

  final int index;

  @override
  List<Object?> get props => [index];
}

class FetchDataByDayEvent extends TransactionEvent {
  const FetchDataByDayEvent();

  @override
  List<Object?> get props => [];
}
