import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/core/validators/empty_field_validator.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const ProfileState()) {
    on<LogoutEvent>(_logout);
    on<FetchUserDetailsEvent>(_fetchUserDetails);
    on<NameFieldChangeEvent>(_checkName);
    on<UpdateNameEvent>(_updateName);
  }

  final AuthenticationRepository _authenticationRepository;
  final db = FirebaseFirestore.instance;

  Future<void> _logout(
    LogoutEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ProfileStateStatus.logOutLoading));
      await _authenticationRepository.logOut();
      emit(state.copyWith(status: ProfileStateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ProfileStateStatus.failure));
    }
  }

  Future<void> _fetchUserDetails(
    FetchUserDetailsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStateStatus.userDataLoading));
    final currentUserId = _authenticationRepository.currentUser?.uid;
    final snapShot = await db.collection('users').doc(currentUserId).get();
    final String? email = snapShot.data()?['email'];
    final String? name = snapShot.data()?['name'];
    emit(state.copyWith(userEmail: email, userName: name));
  }

  void _checkName(
    NameFieldChangeEvent event,
    Emitter<ProfileState> emit,
  ) {
    final name = EmptyFieldValidator.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([name]),
      ),
    );
  }

  Future<void> _updateName(
    UpdateNameEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final name = EmptyFieldValidator.dirty(state.name.value);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([name]),
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(status: ProfileStateStatus.loading));
      try {
        final ref = db
            .collection('users')
            .doc(_authenticationRepository.currentUser!.uid);
        await ref.update({
          'name': state.name.value,
        });
        emit(state.copyWith(status: ProfileStateStatus.success));
      } catch (e) {
        emit(state.copyWith(status: ProfileStateStatus.failure));
      }
    }
  }
}
