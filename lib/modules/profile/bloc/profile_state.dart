part of 'profile_bloc.dart';

enum ProfileStateStatus {
  initial,
  userDataLoading,
  logOutLoading,
  success,
  failure
}

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStateStatus.initial,
    this.userName,
    this.userEmail,
  });

  final ProfileStateStatus status;
  final String? userName;
  final String? userEmail;

  @override
  List<Object?> get props => [status, userName, userEmail];

  ProfileState copyWith({
    ProfileStateStatus? status,
    String? userName,
    String? userEmail,
  }) {
    return ProfileState(
      status: status ?? this.status,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
    );
  }
}
