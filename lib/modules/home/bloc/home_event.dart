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
