part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchAllTransactionData extends HomeEvent {
  const FetchAllTransactionData();
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
  const FetchDataByMonth();
  @override
  List<Object?> get props => [];
}

class FetchDataByYear extends HomeEvent {
  const FetchDataByYear();
  @override
  List<Object?> get props => [];
}

class FetchDataByWeek extends HomeEvent {
  const FetchDataByWeek();
  @override
  List<Object?> get props => [];
}

class FetchDataOfCurrentDay extends HomeEvent {
  const FetchDataOfCurrentDay();
  @override
  List<Object?> get props => [];
}
