part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();
}

final class SignupInitial extends SignupState {
  @override
  List<Object> get props => [];
}
