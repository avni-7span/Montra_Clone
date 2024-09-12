part of 'reset_password_bloc.dart';

enum ResetPasswordStateStatus { initial, loading, success, failure }

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.status = ResetPasswordStateStatus.initial,
    this.email = const Email.pure(),
    this.isValid = false,
  });

  final ResetPasswordStateStatus status;
  final Email email;
  final bool isValid;

  @override
  List<Object?> get props => [status, email, isValid];

  ResetPasswordState copyWith({
    ResetPasswordStateStatus? status,
    Email? email,
    bool? isValid,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
    );
  }
}
