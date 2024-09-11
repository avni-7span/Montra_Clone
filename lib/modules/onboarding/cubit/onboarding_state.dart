part of 'onboarding_cubit.dart';

enum OnboardingStateStatus { initial, success }

class OnboardingState extends Equatable {
  const OnboardingState({
    this.status = OnboardingStateStatus.initial,
    this.currentIndex = 0,
  });

  final OnboardingStateStatus status;
  final int currentIndex;

  @override
  List<Object?> get props => [status, currentIndex];

  OnboardingState copyWith({
    OnboardingStateStatus? status,
    int? currentIndex,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
