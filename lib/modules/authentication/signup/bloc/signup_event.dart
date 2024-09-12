part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class EmailFieldChangeEvent extends SignupEvent {
  const EmailFieldChangeEvent({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class PasswordFieldChangeEvent extends SignupEvent {
  const PasswordFieldChangeEvent({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

class NameFieldChangeEvent extends SignupEvent {
  const NameFieldChangeEvent({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

class SignupAndSendVerificationEmail extends SignupEvent {
  const SignupAndSendVerificationEmail();

  @override
  List<Object?> get props => [];
}

class CheckBoxEvent extends SignupEvent {
  const CheckBoxEvent({required this.isChecked});

  final bool isChecked;

  @override
  List<Object?> get props => [isChecked];
}

class SignUpWithGoogleEvent extends SignupEvent {
  const SignUpWithGoogleEvent();

  @override
  List<Object?> get props => [];
}
