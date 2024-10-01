import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:montra_clone/core/repository/authentication_failure.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/core/validators/email_validator.dart';
import 'package:montra_clone/core/validators/empty_field_validator.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<EmailFieldChangeEvent>(_checkEmail);
    on<PasswordFieldChangeEvent>(_checkPassword);
    on<LoginButtonPressedEvent>(_login);
    on<SendVerificationEmailEvent>(_sendVerificationEmail);
  }

  final AuthenticationRepository _authenticationRepository;

  void _checkEmail(
    EmailFieldChangeEvent event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email]),
      ),
    );
  }

  void _checkPassword(
    PasswordFieldChangeEvent event,
    Emitter<LoginState> emit,
  ) {
    final password = EmptyFieldValidator.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password]),
      ),
    );
  }

  Future<void> _login(
    LoginButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    final email = Email.dirty(state.email.value);
    final password = EmptyFieldValidator.dirty(state.password.value);
    emit(
      state.copyWith(
        email: email,
        password: password,
        isValid: Formz.validate([password, email]),
      ),
    );
    try {
      if (state.isValid) {
        emit(state.copyWith(status: LoginStateStatus.loading));
        await _authenticationRepository.loginWithEmailPassword(
          email: state.email.value.trim(),
          password: state.password.value,
        );

        final currentUser = _authenticationRepository.currentUser;

        final isVerified = currentUser!.emailVerified;

        if (isVerified == false) {
          emit(state.copyWith(status: LoginStateStatus.isNotVerified));
        } else {
          emit(state.copyWith(status: LoginStateStatus.success));
        }
      }
    } on FirebaseException catch (e) {
      emit(
        state.copyWith(
          status: LoginStateStatus.failure,
          error: LogInWithEmailAndPasswordFailure(e.code).message,
        ),
      );
    } catch (e) {
      state.copyWith(
        status: LoginStateStatus.failure,
        error: 'Something went wrong',
      );
    }
  }

  Future<void> _sendVerificationEmail(
    SendVerificationEmailEvent event,
    Emitter<LoginState> emit,
  ) async {
    await _authenticationRepository.sendVerificationEmail();
    state.copyWith(status: LoginStateStatus.emailSent);
  }
}
