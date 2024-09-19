part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LogoutEvent extends ProfileEvent {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}
