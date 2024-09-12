part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class EmailFieldChangeEvent extends LoginEvent {
  const EmailFieldChangeEvent({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class PasswordFieldChangeEvent extends LoginEvent {
  const PasswordFieldChangeEvent({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

class LoginButtonPressedEvent extends LoginEvent {
  const LoginButtonPressedEvent();
  @override
  List<Object?> get props => [];
}

class ForgotPasswordEvent extends LoginEvent {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

class SendVerificationEmailEvent extends LoginEvent {
  const SendVerificationEmailEvent();

  @override
  List<Object?> get props => [];
}
