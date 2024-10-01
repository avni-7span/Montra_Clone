part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();
}

class FetchDataByDayEvent extends TransactionEvent {
  const FetchDataByDayEvent();

  @override
  List<Object?> get props => [];
}

class SetFilterByEvent extends TransactionEvent {
  const SetFilterByEvent({required this.filterBy});
  final String filterBy;

  @override
  List<Object?> get props => [filterBy];
}

class SetSortByEvent extends TransactionEvent {
  const SetSortByEvent({required this.sortBy});
  final String sortBy;

  @override
  List<Object?> get props => [sortBy];
}

class SetCategoryFilterEvent extends TransactionEvent {
  const SetCategoryFilterEvent({required this.categoryFilter});
  final String? categoryFilter;

  @override
  List<Object?> get props => [categoryFilter];
}

class ResetFilterEvent extends TransactionEvent {
  const ResetFilterEvent();
  @override
  List<Object?> get props => [];
}

class FetchDataByFilterEvent extends TransactionEvent {
  const FetchDataByFilterEvent();

  @override
  List<Object?> get props => [];
}
