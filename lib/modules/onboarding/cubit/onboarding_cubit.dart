import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void setIndex({required int index}) {
    emit(
      state.copyWith(
        status: OnboardingStateStatus.success,
        currentIndex: index,
      ),
    );
  }
}
