import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const ProfileState()) {
    on<LogoutEvent>(_logout);
    on<FetchUserDetailsEvent>(_fetchUserDetails);
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
}
