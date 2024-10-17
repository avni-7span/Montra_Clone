part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LogoutEvent extends ProfileEvent {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserDetailsEvent extends ProfileEvent {
  const FetchUserDetailsEvent();

  @override
  List<Object?> get props => [];
}

class NameFieldChangeEvent extends ProfileEvent {
  const NameFieldChangeEvent({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

class UpdateNameEvent extends ProfileEvent {
  const UpdateNameEvent();
  @override
  List<Object?> get props => [];
}
