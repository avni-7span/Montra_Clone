part of 'configuration_cubit.dart';

enum ApiStatus { initial, loading, success, failure }

class ConfigurationState extends Equatable {
  const ConfigurationState({
    this.shouldShowFabInCentre = false,
    this.status = ApiStatus.initial,
    this.currentIndex = 0,
  });

  final bool shouldShowFabInCentre;
  final ApiStatus status;
  final int currentIndex;

  @override
  List<Object?> get props => [shouldShowFabInCentre, status, currentIndex];

  ConfigurationState copyWith({
    bool? shouldShowFabInCentre,
    ApiStatus? status,
    int? currentIndex,
  }) {
    return ConfigurationState(
      shouldShowFabInCentre:
          shouldShowFabInCentre ?? this.shouldShowFabInCentre,
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
