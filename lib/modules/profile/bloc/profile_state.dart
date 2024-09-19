part of 'profile_bloc.dart';

enum ProfileStateStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  const ProfileState({this.status = ProfileStateStatus.initial});

  final ProfileStateStatus status;

  @override
  List<Object?> get props => [status];

  ProfileState copyWith({
    ProfileStateStatus? status,
  }) {
    return ProfileState(
      status: status ?? this.status,
    );
  }
}
