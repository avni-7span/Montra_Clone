import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/core/validators/email_validator.dart';

part 'reset_password_event.dart';

part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const ResetPasswordState()) {
    on<EmailFieldChangeEvent>(_checkEmail);
    on<SendResetPasswordEmailEvent>(_sendResetPasswordEmail);
  }

  final AuthenticationRepository _authenticationRepository;

  void _checkEmail(
    EmailFieldChangeEvent event,
    Emitter<ResetPasswordState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email]),
      ),
    );
  }

  Future<void> _sendResetPasswordEmail(
    ResetPasswordEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    final email = Email.dirty(state.email.value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email]),
      ),
    );
    if (state.isValid) {
      try {
        emit(state.copyWith(status: ResetPasswordStateStatus.loading));
        await _authenticationRepository.sendEmailToResetPassword(
          email: state.email.value.trim(),
        );
        emit(state.copyWith(status: ResetPasswordStateStatus.success));
      } catch (e) {
        emit(state.copyWith(status: ResetPasswordStateStatus.failure));
      }
    }
  }
}
