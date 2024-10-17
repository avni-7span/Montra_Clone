part of 'profile_bloc.dart';

enum ProfileStateStatus {
  initial,
  loading,
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
    this.name = const EmptyFieldValidator.pure(),
    this.isValid = false,
  });

  final ProfileStateStatus status;
  final String? userName;
  final String? userEmail;
  final EmptyFieldValidator name;
  final bool isValid;

  @override
  List<Object?> get props => [status, userName, userEmail, name, isValid];

  ProfileState copyWith({
    ProfileStateStatus? status,
    String? userName,
    String? userEmail,
    EmptyFieldValidator? name,
    bool? isValid,
  }) {
    return ProfileState(
      status: status ?? this.status,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      name: name ?? this.name,
      isValid: isValid ?? this.isValid,
    );
  }
}
