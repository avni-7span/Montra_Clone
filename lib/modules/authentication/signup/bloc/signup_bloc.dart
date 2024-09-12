import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:montra_clone/core/repository/authentication_failure.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/core/validators/email_validator.dart';
import 'package:montra_clone/core/validators/empty_field_validator.dart';
import 'package:montra_clone/core/validators/password_validator.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignupState()) {
    on<EmailFieldChangeEvent>(_checkEmail);
    on<PasswordFieldChangeEvent>(_checkPassword);
    on<NameFieldChangeEvent>(_checkName);
    on<SignupAndSendVerificationEmail>(_signUpAndSendVerificationEmail);
    on<CheckBoxEvent>(_checkToggle);
    on<SignUpWithGoogleEvent>(_signUpWithGoogle);
  }

  final AuthenticationRepository _authenticationRepository;

  void _checkEmail(
    EmailFieldChangeEvent event,
    Emitter<SignupState> emit,
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
    Emitter<SignupState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password]),
      ),
    );
  }

  void _checkName(
    NameFieldChangeEvent event,
    Emitter<SignupState> emit,
  ) {
    final name = EmptyFieldValidator.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([name]),
      ),
    );
  }

  void _signUpAndSendVerificationEmail(
    SignupAndSendVerificationEmail event,
    Emitter<SignupState> emit,
  ) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final name = EmptyFieldValidator.dirty(state.name.value);
    emit(
      state.copyWith(
        email: email,
        password: password,
        name: name,
        isValid: Formz.validate([password, name, email]),
      ),
    );
    emit(state.copyWith(status: SignUpStateStatus.initial));
    if (!state.isChecked) {
      emit(state.copyWith(status: SignUpStateStatus.isNotChecked));
    }
    if (state.isValid && state.isChecked) {
      try {
        emit(state.copyWith(status: SignUpStateStatus.loading));
        await _authenticationRepository.signUpWithEmailPassword(
          email: email.value.trim(),
          password: password.value,
        );
        await _authenticationRepository.sendVerificationEmail();
        emit(state.copyWith(status: SignUpStateStatus.success));
      } on FirebaseException catch (e) {
        emit(
          state.copyWith(
            status: SignUpStateStatus.failure,
            error: SignUpWithEmailAndPasswordFailure(e.code).message,
          ),
        );
      } catch (e) {
        state.copyWith(
          status: SignUpStateStatus.failure,
          error: 'Something went wrong',
        );
      }
    }
  }

  void _checkToggle(
    CheckBoxEvent event,
    Emitter<SignupState> emit,
  ) {
    emit(state.copyWith(isChecked: event.isChecked));
  }

  Future<void> _signUpWithGoogle(
    SignUpWithGoogleEvent event,
    Emitter<SignupState> emit,
  ) async {
    try {
      emit(state.copyWith(status: SignUpStateStatus.signupWithGoogleLoading));
      // await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _authenticationRepository.signUpWithCredentials(
          credential: credential);
      emit(state.copyWith(status: SignUpStateStatus.signupWithGoogleDone));
    } catch (e) {
      emit(state.copyWith(
          status: SignUpStateStatus.failure,
          error: 'Sign up with Google failed,! Please try again later'));
      print('error aavi $e');
    }
  }
}
