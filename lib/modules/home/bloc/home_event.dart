part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchTransactionList extends HomeEvent {
  const FetchTransactionList();
  @override
  List<Object?> get props => [];
}

class FetchAmountDetails extends HomeEvent {
  const FetchAmountDetails();
  @override
  List<Object?> get props => [];
}

class SetFilterEvent extends HomeEvent {
  const SetFilterEvent({required this.filterName});

  final String filterName;

  @override
  List<Object?> get props => [];
}

class FetchDataByMonth extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class FetchDataByYear extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class FetchDataByWeek extends HomeEvent {
  @override
  List<Object?> get props => [];
}
