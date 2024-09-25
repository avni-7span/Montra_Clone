import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:montra_clone/modules/authentication/models/user_model.dart';

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
  final fireStoreInstance = FirebaseFirestore.instance;

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
    if (state.isValid) {
      if (!state.isChecked) {
        emit(state.copyWith(status: SignUpStateStatus.isNotChecked));
      } else {
        try {
          emit(state.copyWith(status: SignUpStateStatus.loading));
          final credential =
              await _authenticationRepository.signUpWithEmailPassword(
            email: email.value.trim(),
            password: password.value,
          );

          await _authenticationRepository.sendVerificationEmail();

          createUserCollection(
            name: state.name.value,
            email: state.email.value,
            userUID: credential.user?.uid ?? '',
          );

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

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _authenticationRepository.signUpWithCredentials(
          credential: credential);
      if (googleUser != null) {
        final userEmail = googleUser.email;
        final userName = googleUser.displayName;
        final userUid = _authenticationRepository.currentUser?.uid;
        createUserCollection(
            userUID: userUid!, email: userEmail, name: userName ?? 'Unknown');
      }
      emit(state.copyWith(status: SignUpStateStatus.signupWithGoogleDone));
    } catch (e) {
      emit(state.copyWith(
          status: SignUpStateStatus.failure,
          error: 'Sign up with Google failed!, Please try again later'));
    }
  }

  Future<void> createUserCollection(
      {required String userUID,
      required String email,
      required String name}) async {
    final UserModel user = UserModel(email: email, name: name);
    await fireStoreInstance
        .collection('users')
        .doc(userUID)
        .set(UserModel.toFireStore(user));
  }
}
