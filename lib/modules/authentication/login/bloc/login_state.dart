part of 'login_bloc.dart';

enum LoginStateStatus {
  initial,
  loading,
  success,
  failure,
  isNotVerified,
  emailSent
}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStateStatus.initial,
    this.isValid = false,
    this.error = '',
    this.email = const Email.pure(),
    this.password = const EmptyFieldValidator.pure(),
  });

  final LoginStateStatus status;
  final bool isValid;
  final String error;
  final Email email;
  final EmptyFieldValidator password;

  @override
  List<Object?> get props => [status, isValid, error, password, error];

  LoginState copyWith({
    LoginStateStatus? status,
    bool? isValid,
    String? error,
    Email? email,
    EmptyFieldValidator? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
