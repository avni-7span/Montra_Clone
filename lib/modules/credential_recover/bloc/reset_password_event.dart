part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
}

class EmailFieldChangeEvent extends ResetPasswordEvent {
  const EmailFieldChangeEvent({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class SendResetPasswordEmailEvent extends ResetPasswordEvent {
  const SendResetPasswordEmailEvent();

  @override
  List<Object?> get props => [];
}
