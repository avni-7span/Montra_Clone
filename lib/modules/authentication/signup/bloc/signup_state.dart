part of 'signup_bloc.dart';

enum SignUpStateStatus {
  initial,
  loading,
  success,
  failure,
  isNotChecked,
  signupWithGoogleLoading,
  signupWithGoogleDone,
}

class SignupState extends Equatable {
  const SignupState({
    this.status = SignUpStateStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.name = const EmptyFieldValidator.pure(),
    this.error = '',
    this.isValid = false,
    this.isChecked = false,
  });

  final SignUpStateStatus status;
  final bool isValid;
  final String error;
  final Email email;
  final EmptyFieldValidator name;
  final Password password;
  final bool isChecked;

  @override
  List<Object?> get props =>
      [status, isValid, error, password, name, error, isChecked];

  SignupState copyWith({
    SignUpStateStatus? status,
    bool? isValid,
    String? error,
    Email? email,
    EmptyFieldValidator? name,
    Password? password,
    bool? isChecked,
  }) {
    return SignupState(
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
