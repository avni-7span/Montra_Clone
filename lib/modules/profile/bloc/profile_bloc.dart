import 'dart:async';

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
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _logout(
    LogoutEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ProfileStateStatus.loading));
      await _authenticationRepository.logOut();
      emit(state.copyWith(status: ProfileStateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ProfileStateStatus.failure));
    }
  }
}
