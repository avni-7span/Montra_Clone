part of 'configuration_cubit.dart';

enum ApiStatus { initial, loading, success, failure }

class ConfigurationState extends Equatable {
  const ConfigurationState({
    this.shouldShowFabInCentre = false,
    this.status = ApiStatus.initial,
  });

  final bool shouldShowFabInCentre;
  final ApiStatus status;

  @override
  List<Object?> get props => [shouldShowFabInCentre, status];

  ConfigurationState copyWith({
    bool? shouldShowFabInCentre,
    ApiStatus? status,
  }) {
    return ConfigurationState(
      shouldShowFabInCentre:
          shouldShowFabInCentre ?? this.shouldShowFabInCentre,
      status: status ?? this.status,
    );
  }
}
